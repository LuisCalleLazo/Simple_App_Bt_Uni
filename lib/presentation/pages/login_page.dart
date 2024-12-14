import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:simple_app_bt_uni/presentation/screens/login_screen.dart';

class LoginPage extends StatefulWidget {
  static String name = "login";
  final BluetoothDevice server;
  const LoginPage({super.key, required this.server});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    return const LoginScreen();
  }
}
