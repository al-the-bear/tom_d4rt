import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ClipRRectEngineLayer - rounded rectangle clipping.
/// Demonstrates clipping with rounded corners.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ClipRRectEngineLayer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rounded Rectangle Clipping', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildClipDemo('Small radius', 8),
                _buildClipDemo('Medium radius', 24),
                _buildClipDemo('Large radius', 48),
                _buildClipDemo('Per-corner', -1),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildClipDemo(String label, double radius) {
  return Column(
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: radius < 0
              ? const BorderRadius.only(topLeft: Radius.circular(40), bottomRight: Radius.circular(40))
              : BorderRadius.circular(radius),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade400, Colors.red.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.image, color: Colors.white, size: 48),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      Text(radius < 0 ? 'Custom corners' : 'radius: $radius', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
    ],
  );
}
