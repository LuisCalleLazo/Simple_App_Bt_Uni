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
  final _formKey = GlobalKey<FormState>();
  bool _codeFieldActive = true;
  bool _otherFieldsActive = true;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNamePController = TextEditingController();
  final TextEditingController lastNameMController = TextEditingController();
  final TextEditingController ciController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isConnecting = false;
    
    // Listeners para los controladores
    codeController.addListener(_handleCodeChange);
    nameController.addListener(_handleOtherFieldChange);
    lastNamePController.addListener(_handleOtherFieldChange);
    lastNameMController.addListener(_handleOtherFieldChange);
    ciController.addListener(_handleOtherFieldChange);
  }

  @override
  void dispose() {
    codeController.removeListener(_handleCodeChange);
    nameController.removeListener(_handleOtherFieldChange);
    lastNamePController.removeListener(_handleOtherFieldChange);
    lastNameMController.removeListener(_handleOtherFieldChange);
    ciController.removeListener(_handleOtherFieldChange);
    super.dispose();
  }

  void _handleCodeChange() {
    final hasText = codeController.text.isNotEmpty;
    if (hasText != !_otherFieldsActive) {
      setState(() {
        _otherFieldsActive = !hasText;
      });
    }
  }

  void _handleOtherFieldChange() {
    final hasText = nameController.text.isNotEmpty ||
        lastNamePController.text.isNotEmpty ||
        lastNameMController.text.isNotEmpty ||
        ciController.text.isNotEmpty;
    
    if (hasText != !_codeFieldActive) {
      setState(() {
        _codeFieldActive = !hasText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo institucional
                Container(
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.asset('assets/icons/logo.png'),
                ),

                const Text(
                  "CONÉCTATE COMO ESTUDIANTE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 22,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 30),

                // Campo de código
                _buildUnderlineInput(
                  controller: codeController,
                  label: "Código de estudiante",
                  icon: Icons.school_outlined,
                  type: TextInputType.number,
                  enabled: _codeFieldActive,
                ),
                const SizedBox(height: 15),

                // Nombre
                _buildUnderlineInput(
                  controller: nameController,
                  label: "Nombres",
                  icon: Icons.person_outline,
                  type: TextInputType.name,
                  enabled: _otherFieldsActive,
                ),
                const SizedBox(height: 15),

                // Apellido Paterno
                _buildUnderlineInput(
                  controller: lastNamePController,
                  label: "Apellido paterno",
                  icon: Icons.people_outline,
                  type: TextInputType.name,
                  enabled: _otherFieldsActive,
                ),
                const SizedBox(height: 15),

                // Apellido Materno
                _buildUnderlineInput(
                  controller: lastNameMController,
                  label: "Apellido materno",
                  icon: Icons.people_outline,
                  type: TextInputType.name,
                  enabled: _otherFieldsActive,
                ),
                const SizedBox(height: 15),

                // CI
                _buildUnderlineInput(
                  controller: ciController,
                  label: "Carnet de Identidad",
                  icon: Icons.badge_outlined,
                  type: TextInputType.number,
                  enabled: _otherFieldsActive,
                ),
                const SizedBox(height: 30),

                // Botón de conexión
                BtnTextDefault(
                  text: isConnecting ? "CONECTANDO..." : "INICIAR CONEXIÓN",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => isConnecting = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        context.push('/home');
                      });
                    }
                  },
                  color: Colors.indigo,
                ),

                // Enlace de ayuda
                TextButton(
                  onPressed: () => _showHelpDialog(context),
                  child: const Text(
                    '¿Necesitas ayuda para conectarte?',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnderlineInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType type,
    required bool enabled,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.indigo,
            width: 1.5,
          ),
        ),
      ),
      child: InputDefault(
        label: label,
        controller: controller,
        icon: icon,
        type: type,
        color: enabled ? Colors.indigo : Colors.grey,
        enabled: enabled,
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Asistencia Técnica', style: TextStyle(color: Colors.indigo)),
        content: const Text(
          'Para conectarte:\n\n1. Verifica que el dispositivo Bluetooth esté activado\n2. Ingresa tus datos exactamente como aparecen en el sistema\n3. Si persiste el error, contacta al departamento de sistemas',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ENTENDIDO', style: TextStyle(color: Colors.indigo)),
          ),
        ],
      ),
    );
  }
}
