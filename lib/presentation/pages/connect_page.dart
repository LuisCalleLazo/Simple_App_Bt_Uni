
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app_bt_uni/presentation/pages/connection_page.dart';
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
          return const SizedBox(
            height: double.infinity,
            child: Center(
              child: Icon(
                Icons.bluetooth_disabled,
                size: 200.0,
                color: Colors.blue,
              ),
            ),
          );
        } else if (future.connectionState == ConnectionState.done) {
          return const ItemConnect();
        } else {
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              title: const Text('Connección con dispositivo'),
            ),
            body: SelectBondedDevicePage(
              onCahtPage: (device1) {
          BluetoothDevice device = device1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginPage(server: device);
              },
            ),
          );
              },
            ),
          ));
        }
      },
    );
  }
}

class ItemConnect extends StatelessWidget {
  const ItemConnect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Connección con dispositivo'),
      ),
      body: SelectBondedDevicePage(
        onCahtPage: (device1) {
          context.push('/auth/login');
        },
      ),
    ));
  }
}
