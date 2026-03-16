import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Deep visual demo for TransformEngineLayer.
/// Demonstrates matrix transformations in rendering.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TransformEngineLayer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Transform Engine Layer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTransformDemo('Rotate', Transform.rotate(angle: math.pi / 6, child: _buildBox())),
                _buildTransformDemo('Scale', Transform.scale(scale: 0.8, child: _buildBox())),
                _buildTransformDemo('Translate', Transform.translate(offset: const Offset(10, 10), child: _buildBox())),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('TransformEngineLayer applies a 4x4 transformation matrix to all child layers.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBox() {
  return Container(
    width: 60, height: 60,
    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
    child: const Center(child: Icon(Icons.star, color: Colors.white)),
  );
}

Widget _buildTransformDemo(String name, Widget child) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 100, height: 100,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Center(child: child),
      ),
      const SizedBox(height: 8),
      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}
