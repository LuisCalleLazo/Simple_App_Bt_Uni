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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
