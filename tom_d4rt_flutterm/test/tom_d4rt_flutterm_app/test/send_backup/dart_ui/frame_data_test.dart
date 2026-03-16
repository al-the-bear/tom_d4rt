import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FrameData - per-frame information.
/// Demonstrates frame callbacks and timing data.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FrameData Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Frame Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Information about each rendered frame', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.cyan.shade100]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.video_camera_back, size: 48, color: Colors.blue),
                const SizedBox(height: 16),
                const Text('Frame Pipeline', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFramePhase('Build', Colors.blue),
                    const Icon(Icons.arrow_forward, size: 20),
                    _buildFramePhase('Layout', Colors.green),
                    const Icon(Icons.arrow_forward, size: 20),
                    _buildFramePhase('Paint', Colors.orange),
                    const Icon(Icons.arrow_forward, size: 20),
                    _buildFramePhase('Comp', Colors.purple),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('FrameData provides:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('• Frame number'),
          const Text('• Frame timing info'),
          const Text('• VSync timestamps'),
        ],
      ),
    ),
  );
}

Widget _buildFramePhase(String label, Color color) {
  return Column(
    children: [
      Container(
        width: 50, height: 50,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.layers, color: Colors.white),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 10)),
    ],
  );
}
