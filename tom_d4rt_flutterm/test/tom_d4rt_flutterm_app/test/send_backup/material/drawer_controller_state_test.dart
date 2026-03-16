import 'package:flutter/material.dart';

/// Deep visual demo for DrawerControllerState - state for DrawerController.
/// Shows drawer animation state management.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DrawerControllerState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      // State transition visualization
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _StateChip('Closed', Colors.grey, 0.0),
            const Icon(Icons.arrow_downward, size: 16),
            _StateChip('Opening', Colors.orange, 0.5),
            const Icon(Icons.arrow_downward, size: 16),
            _StateChip('Open', Colors.green, 1.0),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Controls drawer animation\nopen() / close() methods', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _StateChip extends StatelessWidget {
  final String label;
  final Color color;
  final double value;
  const _StateChip(this.label, this.color, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(width: 8),
          Text('${(value * 100).toInt()}%', style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }
}
