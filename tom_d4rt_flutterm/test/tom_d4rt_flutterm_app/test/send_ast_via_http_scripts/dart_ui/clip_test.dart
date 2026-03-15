import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Clip enum - clip behavior options.
/// Demonstrates none, hardEdge, antiAlias, antiAliasWithSaveLayer.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Clip Behavior Demo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Clip Behavior Options', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildClipDemo(Clip.none, 'Clip.none', 'No clipping (fastest)', Colors.red),
        const SizedBox(height: 16),
        _buildClipDemo(Clip.hardEdge, 'Clip.hardEdge', 'Hard edges, no AA', Colors.orange),
        const SizedBox(height: 16),
        _buildClipDemo(Clip.antiAlias, 'Clip.antiAlias', 'Smooth anti-aliased edges', Colors.green),
        const SizedBox(height: 16),
        _buildClipDemo(Clip.antiAliasWithSaveLayer, 'Clip.antiAliasWithSaveLayer', 'AA with save layer (slowest)', Colors.blue),
      ],
    ),
  );
}

Widget _buildClipDemo(Clip clip, String name, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          clipBehavior: clip,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.5)]),
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 40),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              const SizedBox(height: 4),
              Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}
