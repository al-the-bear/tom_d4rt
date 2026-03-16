import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for GestureSettings - gesture configuration.
/// Demonstrates physicalTouchSlop boundary.
dynamic build(BuildContext context) {
  final settings = View.of(context).gestureSettings;
  
  return Scaffold(
    appBar: AppBar(title: const Text('GestureSettings Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gesture Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildSettingCard('physicalTouchSlop', '${settings.physicalTouchSlop ?? "null"}', 'Physical touch slop'),
          _buildSettingCard('physicalDoubleTapSlop', '${settings.physicalDoubleTapSlop ?? "null"}', 'Double tap slop'),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Text('Defines minimum touch distance thresholds for gesture recognition.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSettingCard(String name, String value, String desc) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: Colors.purple.shade200), borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.touch_app, color: Colors.purple),
      ),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ])),
      Text(value, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
    ]),
  );
}
