import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for SceneBuilder - composites layer tree.
/// Demonstrates building a scene from layers.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SceneBuilder Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scene Builder', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Builds composited layer tree for rendering', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildLayerStack(),
          const SizedBox(height: 24),
          const Text('Common Operations:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildOp('pushOffset', 'Translate children'),
          _buildOp('pushOpacity', 'Apply transparency'),
          _buildOp('pushTransform', 'Apply matrix'),
          _buildOp('pushClipRect', 'Clip to rectangle'),
          _buildOp('addPicture', 'Add recorded drawing'),
          _buildOp('pop', 'End current layer'),
          _buildOp('build', 'Create final Scene'),
        ],
      ),
    ),
  );
}

Widget _buildLayerStack() {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        _buildLayer('root', Colors.blue, 0),
        _buildLayer('pushOffset', Colors.green, 1),
        _buildLayer('pushOpacity', Colors.orange, 2),
        _buildLayer('addPicture', Colors.purple, 3),
        _buildLayer('pop', Colors.orange, 2),
        _buildLayer('pop', Colors.green, 1),
      ],
    ),
  );
}

Widget _buildLayer(String name, Color color, int depth) {
  return Container(
    margin: EdgeInsets.only(left: depth * 20.0, top: 4, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
    child: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: color)),
  );
}

Widget _buildOp(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(children: [
      const Icon(Icons.layers, size: 14, color: Colors.grey),
      const SizedBox(width: 8),
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w500)),
      const SizedBox(width: 8),
      Text('- $desc', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
    ]),
  );
}
