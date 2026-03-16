import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PixelFormat - image data formats.
/// Demonstrates rgba8888 and bgra8888 formats.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PixelFormat Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pixel Formats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildFormatCard('rgba8888', 'R-G-B-A channel order', [Colors.red, Colors.green, Colors.blue, Colors.grey])),
                const SizedBox(width: 16),
                Expanded(child: _buildFormatCard('bgra8888', 'B-G-R-A channel order', [Colors.blue, Colors.green, Colors.red, Colors.grey])),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('8 bits per channel = 32 bits per pixel. Use to specify byte order when decoding raw pixel data.'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFormatCard(String name, String desc, List<Color> channels) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('PixelFormat.$name', style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: channels.map((c) => Container(
            width: 30, height: 30, margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(4)),
            child: Center(child: Text(c == Colors.grey ? 'A' : c == Colors.red ? 'R' : c == Colors.green ? 'G' : 'B',
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
          )).toList(),
        ),
        const SizedBox(height: 12),
        Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11), textAlign: TextAlign.center),
      ],
    ),
  );
}
