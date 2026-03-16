import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for dart:ui image codec functionality.
/// Demonstrates image decoding and encoding concepts.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Image Codec Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Image Codec Pipeline', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildPipeline(),
          const SizedBox(height: 24),
          const Text('Supported Operations:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildOperation('Decode', 'bytes → Image', Icons.download, Colors.green),
          _buildOperation('Encode', 'Image → bytes', Icons.upload, Colors.blue),
          _buildOperation('Resize', 'Scale dimensions', Icons.aspect_ratio, Colors.orange),
          _buildOperation('Frame Extract', 'Get animation frames', Icons.burst_mode, Colors.purple),
        ],
      ),
    ),
  );
}

Widget _buildPipeline() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100]),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPipelineStep('Bytes', Icons.data_array),
        const Icon(Icons.arrow_forward),
        _buildPipelineStep('Codec', Icons.settings),
        const Icon(Icons.arrow_forward),
        _buildPipelineStep('Image', Icons.image),
      ],
    ),
  );
}

Widget _buildPipelineStep(String label, IconData icon) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.blue),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}

Widget _buildOperation(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(width: 8),
        Text(desc, style: TextStyle(color: Colors.grey.shade600)),
      ],
    ),
  );
}
