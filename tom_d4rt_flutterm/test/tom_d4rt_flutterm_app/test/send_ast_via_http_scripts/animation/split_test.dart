import 'package:flutter/material.dart';

/// Demonstrates Split curve - applies different curves to first/second half.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Split Curve Concept', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100, padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                  child: const Column(
                    children: [Text('First Half', style: TextStyle(color: Colors.white, fontSize: 11)), Text('t: 0.0 → 0.5', style: TextStyle(color: Colors.white70, fontSize: 9))],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 100, padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                  child: const Column(
                    children: [Text('Second Half', style: TextStyle(color: Colors.white, fontSize: 11)), Text('t: 0.5 → 1.0', style: TextStyle(color: Colors.white70, fontSize: 9))],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Different curves for each segment', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Use Interval for similar segmentation', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
