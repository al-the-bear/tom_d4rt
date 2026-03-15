import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for dart:ui enums overview.
/// Displays various enums available in dart:ui.
dynamic build(BuildContext context) {
  final enums = [
    ('BlendMode', 'Pixel blending algorithms'),
    ('BlurStyle', 'Blur rendering styles'),
    ('Clip', 'Clipping behavior'),
    ('FilterQuality', 'Image filtering'),
    ('FontStyle', 'Normal or italic'),
    ('PaintingStyle', 'Fill or stroke'),
    ('PathFillType', 'Path fill rules'),
    ('PathOperation', 'Path combining'),
    ('PointMode', 'Point drawing'),
    ('StrokeCap', 'Line end caps'),
    ('StrokeJoin', 'Line corners'),
    ('TileMode', 'Shader tiling'),
  ];
  
  return Scaffold(
    appBar: AppBar(title: const Text('dart:ui Enums Demo')),
    body: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: enums.length,
      itemBuilder: (context, i) {
        final (name, desc) = enums[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.primaries[i % Colors.primaries.length].withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.primaries[i % Colors.primaries.length].withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: Colors.primaries[i % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                    Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
