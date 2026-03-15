import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FragmentProgram - compiled shader program.
/// Demonstrates custom shader concept for visual effects.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FragmentProgram Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Fragment Programs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Custom GPU shaders for visual effects', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue, Colors.cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text('Shader Effect Area', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
          _buildStep(1, 'Write GLSL shader', 'Create .frag file'),
          _buildStep(2, 'Compile with flutter', 'Uses SkSL format'),
          _buildStep(3, 'Load in Dart', 'FragmentProgram.fromAsset'),
          _buildStep(4, 'Create shader', 'program.fragmentShader()'),
        ],
      ),
    ),
  );
}

Widget _buildStep(int num, String title, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(16)),
          child: Center(child: Text('$num', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ],
    ),
  );
}
