import 'package:flutter/material.dart';

/// Deep visual demo for RangeValues class.
/// Holds start and end values for RangeSlider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RangeValues', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ValueBox('start', '0.25'),
                const SizedBox(width: 24),
                _ValueBox('end', '0.75'),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
              child: const Text('RangeValues(0.25, 0.75)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Immutable value class', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ValueBox extends StatelessWidget {
  final String label;
  final String value;
  const _ValueBox(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
