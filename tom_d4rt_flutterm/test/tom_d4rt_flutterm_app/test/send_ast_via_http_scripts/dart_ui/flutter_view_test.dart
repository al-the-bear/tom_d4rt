import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FlutterView - individual viewport into the app.
/// Demonstrates view properties like device pixel ratio and physical size.
dynamic build(BuildContext context) {
  final view = View.of(context);
  
  return Scaffold(
    appBar: AppBar(title: const Text('FlutterView Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('FlutterView Properties', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildPropertyTile('View ID', '${view.viewId}', Icons.fingerprint, Colors.blue),
          _buildPropertyTile('Device Pixel Ratio', '${view.devicePixelRatio.toStringAsFixed(2)}', Icons.zoom_in, Colors.green),
          _buildPropertyTile('Physical Size', '${view.physicalSize.width.toInt()} x ${view.physicalSize.height.toInt()}', Icons.crop_square, Colors.orange),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FlutterView represents:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• A window or display surface'),
                Text('• Physical screen dimensions'),
                Text('• Device pixel ratio for DPI'),
                Text('• View insets and padding'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPropertyTile(String label, String value, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 16),
        Expanded(child: Text(label)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontFamily: 'monospace')),
      ],
    ),
  );
}
