import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ImageDescriptor - image metadata for decoding.
/// Demonstrates raw image construction with width, height, format.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ImageDescriptor Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ImageDescriptor', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Describes raw image data for decoding', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.purple.shade100]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.description, size: 48, color: Colors.blue),
                const SizedBox(height: 16),
                _buildProperty('width', 'Image width in pixels'),
                _buildProperty('height', 'Image height in pixels'),
                _buildProperty('bytesPerPixel', 'Bytes per pixel'),
                _buildProperty('rowBytes', 'Bytes per row'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Creation:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('ImageDescriptor.raw(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('  buffer,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('  width: 100,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('  height: 100,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('  pixelFormat: PixelFormat.rgba8888,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text(')', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ],
            ),
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
        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w500)),
        const SizedBox(width: 8),
        Text('- $desc', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
    ),
  );
}
