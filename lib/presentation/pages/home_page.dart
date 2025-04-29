import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomePage extends StatefulWidget {
  static String name = "home";
  final BluetoothDevice? server;
  const HomePage({super.key, this.server});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _HomePageState extends State<HomePage> {
  static const clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = [];
  final FocusNode _textFieldFocusNode = FocusNode();
  String _messageBuffer = '';
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();
    _setupBluetoothConnection();
  }

  void _setupBluetoothConnection() {
    BluetoothConnection.toAddress("10:06:1C:69:CC:4A").then((_connection) {
      // ignore: avoid_print
      print('Connected to the device');
      setState(() {
        connection = _connection;
        isConnecting = false;
      });

      connection!.input?.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
      // ignore: avoid_print
          print('Disconnecting locally!');
        } else {
      // ignore: avoid_print
          print('Disconnected remotely!');
        }
        if (mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      // ignore: avoid_print
      print('Cannot connect, exception occurred');
      // ignore: avoid_print
      print(error);
    });
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    textEditingController.dispose();
    listScrollController.dispose();
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Resultados")),
      body: GestureDetector(
        onTap: () {
          // Permite cerrar el teclado tocando en cualquier lugar fuera del campo de texto
          _textFieldFocusNode.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: listScrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index].text),
                    subtitle: Text(messages[index].whom == clientID
                        ? "Tú"
                        : "Dispositivo"),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        hintText: "Escribe un mensaje...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: () => _sendMessage(textEditingController.text),
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    if (text.isEmpty || !isConnected) return;

    text = text.trim();
    try {
      connection?.output.add(utf8.encode("$text\r\n"));
      await connection?.output.allSent;

      setState(() {
        messages.add(_Message(clientID, text));
        textEditingController.clear();
      });

      // Enfoque y desplazamiento con retraso mínimo
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _textFieldFocusNode.requestFocus();
        listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
