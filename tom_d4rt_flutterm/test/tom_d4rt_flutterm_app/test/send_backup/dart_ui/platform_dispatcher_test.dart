import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PlatformDispatcher - platform communication.
/// Demonstrates access to platform settings and callbacks.
dynamic build(BuildContext context) {
  final dispatcher = PlatformDispatcher.instance;
  
  return Scaffold(
    appBar: AppBar(title: const Text('PlatformDispatcher Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text('Platform Dispatcher', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Central point for platform communication', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildPropCard('views', '${dispatcher.views.length} FlutterView(s)', Icons.view_quilt),
          _buildPropCard('locales', dispatcher.locales.isNotEmpty ? dispatcher.locales.first.toString() : 'unknown', Icons.language),
          _buildPropCard('textScaleFactor', dispatcher.textScaleFactor.toStringAsFixed(2), Icons.text_fields),
          _buildPropCard('accessibilityFeatures', 'AccessibilityFeatures', Icons.accessibility),
          _buildPropCard('platformBrightness', dispatcher.platformBrightness.name, Icons.brightness_6),
          const Divider(height: 32),
          const Text('Callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildCallback('onBeginFrame', 'Animation frame start'),
          _buildCallback('onDrawFrame', 'Render frame'),
          _buildCallback('onReportTimings', 'Frame timing stats'),
          _buildCallback('onPointerDataPacket', 'Pointer events'),
        ],
      ),
    ),
  );
}

Widget _buildPropCard(String name, String value, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Icon(icon, color: Colors.blue),
      const SizedBox(width: 12),
      Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
      const Spacer(),
      Text(value, style: TextStyle(color: Colors.grey.shade700, fontFamily: 'monospace', fontSize: 12)),
    ]),
  );
}

Widget _buildCallback(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      const Icon(Icons.call_made, color: Colors.green, size: 16),
      const SizedBox(width: 12),
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
      const Spacer(),
      Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
    ]),
  );
}
