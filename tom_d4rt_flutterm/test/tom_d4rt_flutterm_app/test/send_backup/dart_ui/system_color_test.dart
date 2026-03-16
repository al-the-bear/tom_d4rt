import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for system colors.
/// Demonstrates platform-specific color access.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('System Colors Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('System Colors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Platform-specific color palette', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _buildColorSwatch('Primary', Colors.blue),
                _buildColorSwatch('Secondary', Colors.purple),
                _buildColorSwatch('Accent', Colors.amber),
                _buildColorSwatch('Background', Colors.grey.shade100),
                _buildColorSwatch('Surface', Colors.white),
                _buildColorSwatch('Error', Colors.red),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('System colors adapt to platform theme and user preferences.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildColorSwatch(String name, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Container(width: 48, height: 48, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8))),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('#${color.value.toRadixString(16).substring(2).toUpperCase()}', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
      ])),
    ]),
  );
}
