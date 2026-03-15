import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ImageByteFormat - image encoding formats.
/// Demonstrates rawRgba, rawStraightRgba, rawUnmodified, png.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ImageByteFormat Demo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Image Byte Formats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildFormatCard('rawRgba', 'Raw RGBA pixels (premultiplied)', 'Fast, uncompressed', Colors.blue),
        _buildFormatCard('rawStraightRgba', 'Raw RGBA (non-premultiplied)', 'For image editing', Colors.green),
        _buildFormatCard('rawUnmodified', 'Original format bytes', 'Engine format', Colors.orange),
        _buildFormatCard('png', 'PNG encoding', 'Lossless compression', Colors.purple),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('final bytes = await image.toByteData(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text('  format: ImageByteFormat.png,', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              Text(');', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFormatCard(String name, String desc, String note, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)]),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 50, height: 50,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.image, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ImageByteFormat.$name', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
              Text(desc),
              Text(note, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}
