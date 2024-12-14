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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo de imagen
        Positioned.fill(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            const Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Text(
                    "CONECTATE, PARA ASEGURAR LA SEGURIDAD DE TU MOTOCICLETA",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InputDefault(
                label: "Ingresa el código",
                controller: codeController,
                icon: Icons.code,
                type: TextInputType.number,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 4,
              child: BtnTextDefault(
                text: isConnecting ? "Conectando..." : "Iniciar Conexión",
                onPressed: () {
                  context.push('/home');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
