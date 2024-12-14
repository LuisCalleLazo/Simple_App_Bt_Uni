import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_app_bt_uni/presentation/widgets/device.dart';

class SelectBondedDevicePage extends StatefulWidget {
  final bool checkAvailability;
  final void Function(BluetoothDevice device) onCahtPage;

  const SelectBondedDevicePage({
    super.key,
    this.checkAvailability = true,
    required this.onCahtPage,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SelectBondedDevicePage createState() => _SelectBondedDevicePage();
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  List<_DeviceWithAvailability> devices = [];

  // Availability
  late StreamSubscription<BluetoothDiscoveryResult>
      _discoveryStreamSubscription;
  bool _isDiscovering = false;

  _SelectBondedDevicePage();

  // Function to request Bluetooth permissions
  void requestPermissions() async {
    if (await Permission.bluetoothScan.isDenied) {
      await Permission.bluetoothScan.request();
    }

    if (await Permission.bluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }
  }

  @override
  void initState() {
    super.initState();

    // Request Bluetooth permissions when the page is initialized
    requestPermissions();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
                0,
              ),
            )
            .toList();
      });
    });
  }

  // void _restartDiscovery() {
  //   setState(() {
  //     _isDiscovering = true;
  //   });

  //   _startDiscovery();
  // }

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var device = i.current;
          if (device.device == r.device) {
            device.availability = _DeviceAvailability.yes;
            device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    _discoveryStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty && _isDiscovering) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (devices.isEmpty) {
      return const Center(
        child: Text(
          'No hay dispositivos disponibles',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      );
    }

    // Si hay dispositivos, muestra la lista de dispositivos
    List<BluetoothDeviceListEntry> list = devices
        .map(
          (device) => BluetoothDeviceListEntry(
            device: device.device,
            onTap: () {
              widget.onCahtPage(device.device);
            },
          ),
        )
        .toList();

    return ListView(
      children: list,
    );
  }
}

enum _DeviceAvailability {
  maybe,
  yes,
}

class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int rssi;

  _DeviceWithAvailability(this.device, this.availability, this.rssi);
}
