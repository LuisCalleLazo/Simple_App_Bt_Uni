import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomePage extends StatelessWidget {
  static String name = "home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Motocicleta"),
      ),
      body: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  bool isConnected = false;
  String receivedData = "";

  @override
  void initState() {
    super.initState();
    enableBluetooth();
  }

  Future<void> enableBluetooth() async {
    bool isEnabled = await bluetooth.isEnabled ?? false;
    if (!isEnabled) {
      await bluetooth.requestEnable();
    }
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      var connectionResult =
          await BluetoothConnection.toAddress(device.address);
      setState(() {
        connection = connectionResult;
        isConnected = true;
      });

      // Escuchar datos entrantes
      connection?.input?.listen((data) {
        setState(() {
          receivedData = String.fromCharCodes(data);
        });
        print('Data received: $receivedData');
      }).onDone(() {
        print('Disconnected from device');
        setState(() {
          isConnected = false;
        });
      });
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }

  void sendCommand(String command) {
    if (connection != null && isConnected) {
      connection!.output.add(Uint8List.fromList(command.codeUnits));
      connection!.output.allSent;
      // ignore: avoid_print
      print('Command sent: $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HC-05 Controller'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              List<BluetoothDevice> devices =
                  await bluetooth.getBondedDevices();
              showModalBottomSheet(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) {
                  return ListView(
                    children: devices.map((device) {
                      return ListTile(
                        title: Text(device.name ?? "Unknown Device"),
                        subtitle: Text(device.address),
                        onTap: () {
                          connectToDevice(device);
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
            child: const Text('Connect to HC-05'),
          ),
          if (isConnected) ...[
            const Text('Connected to HC-05'),
            ElevatedButton(
              onPressed: () => sendCommand('A'),
              child: const Text('Asegurar Moto (A)'),
            ),
            ElevatedButton(
              onPressed: () => sendCommand('B'),
              child: const Text('Desasegurar Moto (B)'),
            ),
            Text('Received Data: $receivedData'),
          ] else
            const Text('Not connected'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }
}
