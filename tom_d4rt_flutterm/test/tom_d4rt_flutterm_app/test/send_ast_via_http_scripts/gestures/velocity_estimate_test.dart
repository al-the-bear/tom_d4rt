// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// Deep visual demo for VelocityEstimate.
/// Shows velocity calculation confidence.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('VelocityEstimate')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Velocity Estimate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('struct VelocityEstimate', style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('• pixelsPerSecond: Offset'),
                Text('  Estimated velocity vector'),
                SizedBox(height: 8),
                Text('• confidence: double'),
                Text('  0.0-1.0 accuracy of estimate'),
                SizedBox(height: 8),
                Text('• duration: Duration'),
                Text('  Time span of samples used'),
                SizedBox(height: 8),
                Text('• offset: Offset'),
                Text('  Total distance covered'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Confidence gauge
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text('Confidence Interpretation', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _ConfidenceBar('High (>0.9)', 0.95, Colors.green),
                _ConfidenceBar('Medium (0.5-0.9)', 0.7, Colors.orange),
                _ConfidenceBar('Low (<0.5)', 0.3, Colors.red),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('Low confidence = not enough samples or erratic movement',
            style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    ),
  );
}

class _ConfidenceBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _ConfidenceBar(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(width: 120, child: Text(label, style: const TextStyle(fontSize: 11))),
        Expanded(
          child: LinearProgressIndicator(value: value, backgroundColor: Colors.grey.shade200, valueColor: AlwaysStoppedAnimation(color)),
        ),
      ],
    ),
  );
}
