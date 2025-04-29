import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitPage extends StatelessWidget {
  static String name = "init";
  const InitPage({super.key});

  void _goToAlphabet(BuildContext context) {
    context.push("/aphabet_steps");
  }

  void _readBookOnline(BuildContext context) {
    context.push("/list_books");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionCard(
              context,
              icon: Icons.sort_by_alpha,
              title: "Abecedario",
              subtitle: "Aprende las letras",
              onTap: () => _goToAlphabet(context),
            ),
            const SizedBox(height: 20),
            _buildOptionCard(
              context,
              icon: Icons.book,
              title: "Leer libro",
              subtitle: "Lectura en línea",
              onTap: () => _readBookOnline(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
