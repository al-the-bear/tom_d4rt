import 'package:flutter/material.dart';

/// Deep visual demo for SwitchListTile widget.
/// ListTile with a trailing Switch.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SwitchListTile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(
          children: [
            _SwitchTile('Wi-Fi', 'Connected', Icons.wifi, true),
            const Divider(height: 1),
            _SwitchTile('Bluetooth', 'Off', Icons.bluetooth, false),
            const Divider(height: 1),
            _SwitchTile('Airplane', 'Disabled', Icons.airplanemode_active, false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('title, subtitle, secondary, value', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isOn;
  const _SwitchTile(this.title, this.subtitle, this.icon, this.isOn);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: isOn ? Colors.blue : Colors.grey, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 11)),
                Text(subtitle, style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 24,
            decoration: BoxDecoration(color: isOn ? Colors.blue : Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(2),
            alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
          ),
        ],
      ),
    );
  }
}
