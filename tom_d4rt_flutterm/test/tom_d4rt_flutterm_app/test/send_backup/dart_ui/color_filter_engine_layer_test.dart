import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ColorFilterEngineLayer - applies color filters to layer.
/// Demonstrates color transformation effects.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ColorFilterEngineLayer Demo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Color Filter Effects', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildFilterDemo('Original', null),
        const SizedBox(height: 16),
        _buildFilterDemo('Mode: multiply', ColorFilter.mode(Colors.blue.withValues(alpha: 0.5), BlendMode.multiply)),
        const SizedBox(height: 16),
        _buildFilterDemo('Mode: colorBurn', ColorFilter.mode(Colors.orange.withValues(alpha: 0.5), BlendMode.colorBurn)),
        const SizedBox(height: 16),
        _buildFilterDemo('Grayscale Matrix', const ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ])),
        const SizedBox(height: 16),
        _buildFilterDemo('Sepia Matrix', const ColorFilter.matrix([
          0.393, 0.769, 0.189, 0, 0,
          0.349, 0.686, 0.168, 0, 0,
          0.272, 0.534, 0.131, 0, 0,
          0, 0, 0, 1, 0,
        ])),
      ],
    ),
  );
}

Widget _buildFilterDemo(String label, ColorFilter? filter) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        ColorFiltered(
          colorFilter: filter ?? const ColorFilter.mode(Colors.transparent, BlendMode.dst),
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue]),
            ),
            child: const Icon(Icons.image, color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}
