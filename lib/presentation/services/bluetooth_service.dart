import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothService {
  BluetoothConnection? _connection;
  bool get isConnected => _connection != null && _connection!.isConnected;

  // Obtener dispositivos emparejados
  Future<List<BluetoothDevice>> getBondedDevices() async {
    try {
      return await FlutterBluetoothSerial.instance.getBondedDevices();
    } catch (e) {
      throw Exception("Error al obtener dispositivos emparejados: $e");
    }
  }

  // Conectar a un dispositivo Bluetooth
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      _connection = await BluetoothConnection.toAddress(device.address);
    } catch (e) {
      throw Exception("Error al conectar con el dispositivo: $e");
    }
  }

  // Enviar datos al dispositivo
  Future<void> sendData(String data) async {
    if (!isConnected) {
      throw Exception("No hay conexión con un dispositivo Bluetooth");
    }
    try {
      _connection!.output.add(Uint8List.fromList(data.codeUnits));
      await _connection!.output.allSent;
    } catch (e) {
      throw Exception("Error al enviar datos: $e");
    }
  }

  // Recibir datos del dispositivo
  Stream<String> receiveData() {
    if (!isConnected) {
      throw Exception("No hay conexión con un dispositivo Bluetooth");
    }
    return _connection!.input!.map((Uint8List data) {
      return String.fromCharCodes(data).trim();
    });
  }

  // Cerrar la conexión
  Future<void> disconnect() async {
    try {
      await _connection?.close();
      _connection = null;
    } catch (e) {
      throw Exception("Error al cerrar la conexión: $e");
    }
  }
}
