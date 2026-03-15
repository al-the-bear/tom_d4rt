import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DeviceGestureSettings.
/// Shows device-specific gesture configuration.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DeviceGestureSettings')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Device Gesture Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _SettingRow(name: 'touchSlop', value: '18.0 px', desc: 'Min drag distance'),
          _SettingRow(name: 'panSlop', value: '36.0 px', desc: 'Pan threshold'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Text('Touch Slop Visualization', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.blue, width: 2)),
                  child: const Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.touch_app, color: Colors.blue),
                      Text('18px', style: TextStyle(fontSize: 10)),
                    ]),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Drag recognized outside circle', style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _SettingRow extends StatelessWidget {
  final String name;
  final String value;
  final String desc;
  const _SettingRow({required this.name, required this.value, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
        Text(value, style: const TextStyle(fontFamily: 'monospace')),
        const SizedBox(width: 12),
        Text(desc, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ]),
    );
  }
}
