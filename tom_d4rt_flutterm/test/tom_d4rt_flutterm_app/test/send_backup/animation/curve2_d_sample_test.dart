import 'package:flutter/material.dart';

/// Demonstrates Curve2DSample - a sampled point on a 2D curve.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Curve2DSample Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('A point on a 2D curve', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
                  child: const Column(
                    children: [Text('t', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('0.5', style: TextStyle(color: Colors.white))],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: Colors.teal),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                  child: const Column(
                    children: [Text('value', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('Offset(0.3, 0.7)', style: TextStyle(color: Colors.white, fontSize: 10))],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Contains t (time) and value (position)', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
