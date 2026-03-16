import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for KeyEventDeviceType - keyboard device types.
/// Demonstrates keyboard vs other input device types.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('KeyEventDeviceType Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Key Event Device Types', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildDeviceCard('keyboard', 'Physical keyboard', Icons.keyboard, Colors.blue),
          _buildDeviceCard('directionalPad', 'D-pad controller', Icons.gamepad, Colors.green),
          _buildDeviceCard('gamepad', 'Game controller', Icons.sports_esports, Colors.orange),
          _buildDeviceCard('joystick', 'Joystick input', Icons.control_camera, Colors.purple),
          _buildDeviceCard('hdmi', 'HDMI input', Icons.settings_input_hdmi, Colors.red),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Use deviceType to handle different input sources appropriately.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDeviceCard(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KeyEventDeviceType.$name', style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}
