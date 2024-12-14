import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  static String name = "login";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "LOGIN",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.abc),
            onPressed: () {
              context.push('/home');
            },
          )
        ],
      ),
    );
  }
}
