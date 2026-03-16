import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Picture - recorded drawing commands.
/// Demonstrates Picture as immutable recording from PictureRecorder.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Picture Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Picture', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Immutable recording of canvas operations', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildWorkflow(),
          const SizedBox(height: 24),
          const Text('Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildMethod('dispose', 'Release resources'),
          _buildMethod('toImage', 'Rasterize to Image (async)'),
          _buildMethod('toImageSync', 'Rasterize to Image (sync)'),
          _buildMethod('approximateBytesUsed', 'GPU memory estimate'),
        ],
      ),
    ),
  );
}

Widget _buildWorkflow() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStep('1', 'PictureRecorder', 'Create recorder'),
        const Icon(Icons.arrow_forward, color: Colors.blue),
        _buildStep('2', 'Canvas', 'Draw commands'),
        const Icon(Icons.arrow_forward, color: Colors.blue),
        _buildStep('3', 'Picture', 'End recording'),
      ],
    ),
  );
}

Widget _buildStep(String num, String title, String subtitle) {
  return Column(
    children: [
      CircleAvatar(radius: 16, backgroundColor: Colors.blue, child: Text(num, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      const SizedBox(height: 4),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
      Text(subtitle, style: const TextStyle(fontSize: 9, color: Colors.grey)),
    ],
  );
}

Widget _buildMethod(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
      const SizedBox(width: 12),
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w500)),
      const SizedBox(width: 8),
      Text('- $desc', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
    ]),
  );
}
