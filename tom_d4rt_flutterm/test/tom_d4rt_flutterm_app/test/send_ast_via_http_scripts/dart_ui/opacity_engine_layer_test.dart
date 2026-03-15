import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for OpacityEngineLayer - opacity transformation layer.
/// Demonstrates applying opacity to child layers.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('OpacityEngineLayer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Opacity Engine Layer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildOpacityDemo(1.0, 'alpha: 255')),
                const SizedBox(width: 12),
                Expanded(child: _buildOpacityDemo(0.7, 'alpha: 178')),
                const SizedBox(width: 12),
                Expanded(child: _buildOpacityDemo(0.4, 'alpha: 102')),
                const SizedBox(width: 12),
                Expanded(child: _buildOpacityDemo(0.1, 'alpha: 25')),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('OpacityEngineLayer applies alpha to all child layers in the compositing tree.', textAlign: TextAlign.center),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOpacityDemo(double opacity, String label) {
  return Column(
    children: [
      Expanded(
        child: Opacity(
          opacity: opacity,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Icon(Icons.star, color: Colors.white, size: 40)),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text('\${(opacity * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
    ],
  );
}
