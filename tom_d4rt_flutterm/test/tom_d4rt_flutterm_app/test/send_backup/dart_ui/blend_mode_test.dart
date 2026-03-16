import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for BlendMode - pixel blending algorithms.
/// Demonstrates various blend modes: srcOver, multiply, screen, overlay, etc.
dynamic build(BuildContext context) {
  final modes = [
    (BlendMode.srcOver, 'srcOver', 'Default compositing'),
    (BlendMode.multiply, 'multiply', 'Darkening blend'),
    (BlendMode.screen, 'screen', 'Lightening blend'),
    (BlendMode.overlay, 'overlay', 'Contrast boost'),
    (BlendMode.colorDodge, 'colorDodge', 'Brighten colors'),
    (BlendMode.colorBurn, 'colorBurn', 'Darken colors'),
    (BlendMode.difference, 'difference', 'Color difference'),
    (BlendMode.exclusion, 'exclusion', 'Soft difference'),
  ];
  
  return Scaffold(
    appBar: AppBar(title: const Text('BlendMode Demo')),
    body: GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: modes.length,
      itemBuilder: (context, i) {
        final (mode, name, desc) = modes[i];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 50, height: 50, color: Colors.blue),
                  Positioned(
                    left: 25,
                    top: 25,
                    child: Container(
                      width: 50,
                      height: 50,
                      foregroundDecoration: BoxDecoration(
                        color: Colors.red,
                        backgroundBlendMode: mode,
                      ),
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'monospace')),
              Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
        );
      },
    ),
  );
}
