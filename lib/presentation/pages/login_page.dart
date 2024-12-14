import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app_bt_uni/presentation/widgets/btn_text.dart';
import 'package:simple_app_bt_uni/presentation/widgets/input_default.dart';

class LoginPage extends StatefulWidget {
  static String name = "login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  text: "Iniciar Conección",
                  onPressed: () {
                    context.push('/home');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
