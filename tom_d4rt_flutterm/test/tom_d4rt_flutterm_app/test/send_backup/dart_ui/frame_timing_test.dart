import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FrameTiming - timing information for frames.
/// Demonstrates frame duration metrics and performance tracking.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FrameTiming Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Frame Timing', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Performance metrics for each frame', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildMetricCard('buildDuration', 'Time to build widgets', '4.2ms', Colors.blue),
          _buildMetricCard('rasterDuration', 'Time to rasterize', '8.1ms', Colors.green),
          _buildMetricCard('totalSpan', 'Total frame time', '12.3ms', Colors.orange),
          const SizedBox(height: 24),
          _buildFrameBar('Frame 1', 12.3, false),
          _buildFrameBar('Frame 2', 8.5, false),
          _buildFrameBar('Frame 3', 22.1, true),
          _buildFrameBar('Frame 4', 10.2, false),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(width: 12, height: 12, color: Colors.green),
              const SizedBox(width: 8),
              const Text('< 16.67ms (60 FPS)', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 24),
              Container(width: 12, height: 12, color: Colors.red),
              const SizedBox(width: 8),
              const Text('> 16.67ms (dropped)', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildMetricCard(String name, String desc, String value, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border(left: BorderSide(color: color, width: 4)), color: color.withValues(alpha: 0.1)),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            ],
          ),
        ),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontFamily: 'monospace')),
      ],
    ),
  );
}

Widget _buildFrameBar(String label, double ms, bool dropped) {
  final width = (ms / 30 * 200).clamp(20.0, 200.0);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(width: 60, child: Text(label, style: const TextStyle(fontSize: 12))),
        Container(width: width, height: 20, color: dropped ? Colors.red : Colors.green),
        const SizedBox(width: 8),
        Text('${ms}ms', style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
      ],
    ),
  );
}
