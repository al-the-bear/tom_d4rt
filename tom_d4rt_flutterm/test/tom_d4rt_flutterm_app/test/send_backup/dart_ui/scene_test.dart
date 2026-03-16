import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Scene - renderable layer tree.
/// Demonstrates Scene as output from SceneBuilder.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Scene Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scene', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Immutable composited layer tree', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildPipeline(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Scene Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildProp('toImage', 'Rasterize to Image'),
                _buildProp('dispose', 'Release GPU resources'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Scene is the final output passed to FlutterView.render() for display.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPipeline() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildStep('SceneBuilder', 'Build layers', Colors.blue),
      const Icon(Icons.arrow_forward, color: Colors.grey),
      _buildStep('Scene', 'Layer tree', Colors.purple),
      const Icon(Icons.arrow_forward, color: Colors.grey),
      _buildStep('render()', 'Display', Colors.green),
    ],
  );
}

Widget _buildStep(String title, String subtitle, Color color) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
        child: Icon(Icons.layers, color: color),
      ),
      const SizedBox(height: 4),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
      Text(subtitle, style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
    ],
  );
}

Widget _buildProp(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
      const SizedBox(width: 8),
      Text('- $desc', style: TextStyle(color: Colors.grey.shade700, fontSize: 11)),
    ]),
  );
}
