import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Codec - image decoder for animated images.
/// Demonstrates codec concept for decoding image formats like GIF.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Codec Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Image Codec', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Decodes image data into frames', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.indigo.shade100, Colors.purple.shade100]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.image, size: 64, color: Colors.indigo),
                const SizedBox(height: 16),
                const Text('Codec Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildProperty('frameCount', 'Number of frames'),
                _buildProperty('repetitionCount', 'Animation loops'),
                const SizedBox(height: 16),
                const Text('Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildMethod('getNextFrame()', 'Get next FrameInfo'),
                _buildMethod('dispose()', 'Release resources'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('Create via: instantiateImageCodec(bytes)', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

Widget _buildProperty(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.indigo, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Text(name, style: const TextStyle(fontFamily: 'monospace')),
        const SizedBox(width: 8),
        Text('- $desc', style: TextStyle(color: Colors.grey.shade600)),
      ],
    ),
  );
}

Widget _buildMethod(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        const Icon(Icons.code, size: 16, color: Colors.purple),
        const SizedBox(width: 8),
        Text(name, style: const TextStyle(fontFamily: 'monospace')),
        const SizedBox(width: 8),
        Text('- $desc', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
    ),
  );
}
