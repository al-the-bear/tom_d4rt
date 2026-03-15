import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for EngineLayer - base class for compositing layers.
/// Demonstrates the layer tree concept in the rendering pipeline.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('EngineLayer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Engine Layer Hierarchy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildLayerTree(),
          const SizedBox(height: 24),
          const Text('Layer Types:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildLayerType('ClipRectEngineLayer', Colors.blue),
          _buildLayerType('OpacityEngineLayer', Colors.green),
          _buildLayerType('TransformEngineLayer', Colors.orange),
          _buildLayerType('ColorFilterEngineLayer', Colors.purple),
          _buildLayerType('BackdropFilterEngineLayer', Colors.red),
        ],
      ),
    ),
  );
}

Widget _buildLayerTree() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTreeNode('Root Layer', 0, Colors.blue),
        _buildTreeNode('├─ Transform', 1, Colors.green),
        _buildTreeNode('│  ├─ Clip', 2, Colors.orange),
        _buildTreeNode('│  │  └─ Paint', 3, Colors.purple),
        _buildTreeNode('│  └─ Opacity', 2, Colors.red),
        _buildTreeNode('└─ Picture', 1, Colors.teal),
      ],
    ),
  );
}

Widget _buildTreeNode(String label, int depth, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 16.0, top: 4, bottom: 4),
    child: Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontFamily: 'monospace')),
      ],
    ),
  );
}

Widget _buildLayerType(String name, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 12),
        Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
      ],
    ),
  );
}
