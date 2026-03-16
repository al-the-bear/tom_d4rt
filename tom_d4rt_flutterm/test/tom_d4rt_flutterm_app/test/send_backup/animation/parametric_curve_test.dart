import 'package:flutter/material.dart';

/// Demonstrates ParametricCurve - base class for curves that return T from t.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ParametricCurve<T>', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('abstract class', style: TextStyle(fontSize: 10, color: Colors.grey)),
            const Text('ParametricCurve<T>', style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Column(
                children: [
                  Text('T transform(double t)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                  SizedBox(height: 4),
                  Text('Maps t ∈ [0,1] to T', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SubclassChip('Curve'),
                SizedBox(width: 8),
                _SubclassChip('Curve2D'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class _SubclassChip extends StatelessWidget {
  final String name;
  const _SubclassChip(this.name);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(4)),
    child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 10)),
  );
}
