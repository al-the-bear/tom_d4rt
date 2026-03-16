import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ClipRSuperellipseEngineLayer - superellipse clipping.
/// Demonstrates smooth rounded rectangle (squircle) clipping.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ClipRSuperellipse Demo')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Superellipse Clipping', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Smooth "squircle" corners like iOS icons', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
              // Note: RSuperellipse provides smoother corners than BorderRadius
            ),
            child: const Center(
              child: Icon(Icons.apps, color: Colors.white, size: 80),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildComparison('RRect', false),
              const SizedBox(width: 24),
              _buildComparison('RSuperellipse', true),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildComparison(String label, bool isSuper) {
  return Column(
    children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isSuper ? Colors.purple : Colors.blue,
          borderRadius: BorderRadius.circular(isSuper ? 24 : 20),
        ),
      ),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}
