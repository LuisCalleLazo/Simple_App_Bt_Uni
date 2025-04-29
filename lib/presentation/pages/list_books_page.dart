import 'package:flutter/material.dart';
import 'dart:async';

class ListBooksPage extends StatelessWidget {
  static String name = "list_books";
  const ListBooksPage({super.key});

  final List<Map<String, String>> books = const [
    {"title": "El Principito", "author": "Antoine de Saint-Exupéry"},
    {"title": "Cien años de soledad", "author": "Gabriel García Márquez"},
    {"title": "Don Quijote de la Mancha", "author": "Miguel de Cervantes"},
    {"title": "Rayuela", "author": "Julio Cortázar"},
    {"title": "Pedro Páramo", "author": "Juan Rulfo"},
  ];

  void _showPlaybackDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        double progress = 0.0;
        Timer? timer;

        return StatefulBuilder(
          builder: (context, setState) {
            // Iniciar el Timer solo la primera vez
            timer ??= Timer.periodic(const Duration(milliseconds: 100), (t) {
                progress += 0.02;
                if (progress >= 1.0) {
                  t.cancel();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Finalizó la reproducción de '$title'")),
                  );
                }
                setState(() {});
              });

            return AlertDialog(
              title: Text("Reproduciendo '$title'"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.device_hub_outlined, size: 40),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(value: progress),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    timer?.cancel();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Libros")),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.book),
              title: Text(book["title"]!),
              subtitle: Text("Autor: ${book["author"]}"),
              onTap: () {
                _showPlaybackDialog(context, book["title"]!);
              },
            ),
          );
        },
      ),
    );
  }
}
