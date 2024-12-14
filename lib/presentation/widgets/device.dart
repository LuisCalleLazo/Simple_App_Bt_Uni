import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:simple_app_bt_uni/presentation/widgets/btn_text.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final void Function()? onTap;
  final BluetoothDevice device;

  const BluetoothDeviceListEntry({
    super.key,
    required this.onTap,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.devices),
      title: Text(device.name ?? "Unknown device"),
      subtitle: Text(device.address.toString()),
      trailing: SizedBox(
        width: 100,
        child: BtnTextDefault(
          text: 'Connect',
          onPressed: onTap,
          color: Colors.blue,
        ),
      ),
    );
  }
}