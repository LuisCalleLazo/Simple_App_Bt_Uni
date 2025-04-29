import 'package:flutter/material.dart';

class AlphabetStepsPage extends StatefulWidget {
  static String name = "aphabet_steps";
  const AlphabetStepsPage({super.key});

  @override
  State<AlphabetStepsPage> createState() => _AlphabetStepsPageState();
}

class _AlphabetStepsPageState extends State<AlphabetStepsPage> {
  // Lista de letras del abecedario en español (puedes adaptarla si necesitas ñ o eliminar la 'll')
  final List<String> _alphabet = List.generate(26, (i) => String.fromCharCode(65 + i)); // A-Z
  late List<bool> _completed; // Estado de cada letra

  @override
  void initState() {
    super.initState();
    _completed = List<bool>.filled(_alphabet.length, false);
  }

  void markStepCompleted(int index) {
    setState(() {
      _completed[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pasos del Abecedario (Braille)')),
      body: ListView.builder(
        itemCount: _alphabet.length,
        itemBuilder: (context, index) {
          final letter = _alphabet[index];
          return ListTile(
            leading: CircleAvatar(child: Text(letter)),
            title: Text('Letra $letter'),
            trailing: Icon(
              _completed[index] ? Icons.check_circle : Icons.radio_button_unchecked,
              color: _completed[index] ? Colors.green : Colors.grey,
            ),
            onTap: () {
              // Por ahora marcamos al tocar, pero después puedes usar señales
              markStepCompleted(index);
            },
          );
        },
      ),
    );
  }
}
