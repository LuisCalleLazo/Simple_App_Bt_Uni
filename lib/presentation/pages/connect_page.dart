import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:simple_app_bt_uni/presentation/pages/login_page.dart';

class ConnectPage extends StatelessWidget {
  static String name = "connect";
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterBluetoothSerial.instance.requestEnable(),
      builder: (context, future) {
        if (future.connectionState == ConnectionState.waiting) {
          return _buildLoadingScreen();
        }
        return const ItemConnect();
      },
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/bluetooth_loading.gif', height: 200),
            const SizedBox(height: 30),
            const Text(
              'Activando conexión educativa',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
            ),
            const SizedBox(height: 15),
            Text(
              'Preparando entorno de aprendizaje interactivo',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemConnect extends StatelessWidget {
  const ItemConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Aula Interactiva'),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/logo.png'),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: Column(
          children: [
            const _HeaderSection(),
            Expanded(
              child: SelectBondedDevicePage(
                onCahtPage: (device) => _navigateToLogin(context, device),
                customWidget: _buildDeviceListDecorator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceListDecorator() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'DISPOSITIVOS DISPONIBLES',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 3,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _navigateToLogin(BuildContext context, BluetoothDevice device) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => LoginPage(server: device),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Guía Rápida'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpItem(Icons.bluetooth, '1. Activa Bluetooth'),
            _buildHelpItem(Icons.search, '2. Selecciona dispositivo'),
            _buildHelpItem(Icons.group, '3. Conéctate con tus estudiantes'),
            const SizedBox(height: 20),
            const Text(
              'Esta app permite controlar dispositivos educativos y gestionar actividades interactivas en el aula.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset('assets/icons/logo.png', height: 100),
          const SizedBox(height: 15),
          const Text(
            'Conexión Educativa Interactiva',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Selecciona el dispositivo educativo para comenzar la sesión',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Clase modificada para personalizar la lista de dispositivos
class SelectBondedDevicePage extends StatelessWidget {
  final Function(BluetoothDevice) onCahtPage;
  final Widget? customWidget;

  const SelectBondedDevicePage({
    required this.onCahtPage,
    this.customWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterBluetoothSerial.instance.getBondedDevices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final devices = snapshot.data as List<BluetoothDevice>? ?? [];

        return Column(
          children: [
            if (customWidget != null) customWidget!,
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return _buildDeviceCard(device, context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeviceCard(BluetoothDevice device, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: const Icon(Icons.devices, color: Colors.blueAccent),
        title: Text(
          device.name ?? 'Dispositivo desconocido',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(device.address),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => onCahtPage(device),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
