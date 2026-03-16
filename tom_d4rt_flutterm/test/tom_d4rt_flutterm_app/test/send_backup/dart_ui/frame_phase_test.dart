import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FramePhase - phases of frame rendering.
/// Demonstrates vsyncStart, buildStart, rasterStart, rasterFinish.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FramePhase Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Frame Phases', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildPhaseTimeline(),
          const SizedBox(height: 24),
          _buildPhaseCard('vsyncStart', 'VSync signal received', Icons.sync, Colors.blue),
          _buildPhaseCard('buildStart', 'Widget build begins', Icons.build, Colors.green),
          _buildPhaseCard('rasterStart', 'Rasterization begins', Icons.brush, Colors.orange),
          _buildPhaseCard('rasterFinish', 'Rasterization complete', Icons.check_circle, Colors.purple),
        ],
      ),
    ),
  );
}

Widget _buildPhaseTimeline() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        _buildTimelineNode('V', Colors.blue),
        Expanded(child: Container(height: 2, color: Colors.grey.shade400)),
        _buildTimelineNode('B', Colors.green),
        Expanded(child: Container(height: 2, color: Colors.grey.shade400)),
        _buildTimelineNode('R', Colors.orange),
        Expanded(child: Container(height: 2, color: Colors.grey.shade400)),
        _buildTimelineNode('F', Colors.purple),
      ],
    ),
  );
}

Widget _buildTimelineNode(String label, Color color) {
  return Container(
    width: 36, height: 36,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
  );
}

Widget _buildPhaseCard(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FramePhase.$name', style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}
