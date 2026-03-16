import 'package:flutter/material.dart';

/// Demonstrates AnimationLocalStatusListenersMixin - manages status listeners.
/// Notifies when animation transitions between states (forward/reverse/completed/dismissed).
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimationLocalStatusListenersMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      const SizedBox(height: 16),
      // Status flow diagram
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Animation Status Flow', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusChip('dismissed', Colors.grey),
                const Icon(Icons.arrow_forward, size: 14),
                _StatusChip('forward', Colors.blue),
                const Icon(Icons.arrow_forward, size: 14),
                _StatusChip('completed', Colors.green),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusChip('completed', Colors.green),
                const Icon(Icons.arrow_forward, size: 14),
                _StatusChip('reverse', Colors.orange),
                const Icon(Icons.arrow_forward, size: 14),
                _StatusChip('dismissed', Colors.grey),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Notifies on state transitions', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
      child: Text(label, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.bold)),
    );
  }
}
