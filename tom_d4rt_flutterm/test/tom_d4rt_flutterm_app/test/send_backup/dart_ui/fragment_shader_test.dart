import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FragmentShader - instance of a shader program.
/// Demonstrates shader uniforms and usage with Paint.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FragmentShader Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('FragmentShader', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const RadialGradient(
                colors: [Colors.white, Colors.purple, Colors.blue],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: const Center(child: Text('Shader Output', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(height: 24),
          const Text('Setting Uniforms:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildUniformType('setFloat(index, value)', 'Float uniform', Colors.blue),
          _buildUniformType('setImageSampler(index, image)', 'Texture sampler', Colors.green),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usage with Paint:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('paint.shader = fragmentShader', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('canvas.drawRect(rect, paint)', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildUniformType(String method, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Icon(Icons.code, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(method, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}
