import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FrameInfo - decoded image frame information.
/// Demonstrates animation frame info from Codec.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FrameInfo Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('FrameInfo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Information about a single animation frame', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildFrameTimeline(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FrameInfo Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('• image - The decoded Image'),
                Text('• duration - Frame display duration'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('FrameInfo frameInfo = await codec.getNextFrame();', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFrameTimeline() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        const Text('Animation Frames', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (i) => _buildFrame(i + 1, i == 2)),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('100ms', style: TextStyle(fontSize: 10)),
            Text('100ms', style: TextStyle(fontSize: 10)),
            Text('200ms', style: TextStyle(fontSize: 10)),
            Text('100ms', style: TextStyle(fontSize: 10)),
            Text('100ms', style: TextStyle(fontSize: 10)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFrame(int num, bool highlight) {
  return Container(
    width: 50, height: 50,
    decoration: BoxDecoration(
      color: highlight ? Colors.blue : Colors.grey.shade300,
      borderRadius: BorderRadius.circular(8),
      border: highlight ? Border.all(color: Colors.blue.shade700, width: 2) : null,
    ),
    child: Center(child: Text('$num', style: TextStyle(color: highlight ? Colors.white : Colors.black, fontWeight: FontWeight.bold))),
  );
}
