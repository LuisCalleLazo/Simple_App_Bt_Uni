import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app_bt_uni/presentation/widgets/btn_text.dart';
import 'package:simple_app_bt_uni/presentation/widgets/input_default.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool isConnecting;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNamePController = TextEditingController();
  final TextEditingController lastNameMController = TextEditingController();
  final TextEditingController ciController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isConnecting = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Fondo sólido
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "CONECTATE, PARA INGRESAR COMO ESTUDIANTE",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 30),
              InputDefault(
                label: "Código de estudiante",
                controller: codeController,
                icon: Icons.code,
                type: TextInputType.number,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              InputDefault(
                label: "Nombres",
                controller: nameController,
                icon: Icons.person,
                type: TextInputType.name,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              InputDefault(
                label: "Apellido paterno",
                controller: lastNamePController,
                icon: Icons.person_outline,
                type: TextInputType.name,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              InputDefault(
                label: "Apellido materno",
                controller: lastNameMController,
                icon: Icons.person_outline,
                type: TextInputType.name,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              InputDefault(
                label: "CI",
                controller: ciController,
                icon: Icons.credit_card,
                type: TextInputType.number,
                color: Colors.white,
              ),
              const SizedBox(height: 30),
              BtnTextDefault(
                text: isConnecting ? "Conectando..." : "Iniciar Conexión",
                onPressed: () {
                  context.push('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
