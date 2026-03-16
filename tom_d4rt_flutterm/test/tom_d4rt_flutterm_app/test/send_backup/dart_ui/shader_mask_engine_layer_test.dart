import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ShaderMaskEngineLayer.
/// Demonstrates shader-based masking in rendering.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ShaderMaskEngineLayer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Shader Mask Engine Layer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Center(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.transparent],
                ).createShader(bounds);
              },
              child: Container(
                width: 200, height: 200,
                color: Colors.blue,
                child: const Center(child: Icon(Icons.star, color: Colors.white, size: 80)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('ShaderMaskEngineLayer applies a shader as a mask to child layers, creating gradient fade effects.'),
          ),
        ],
      ),
    ),
  );
}
