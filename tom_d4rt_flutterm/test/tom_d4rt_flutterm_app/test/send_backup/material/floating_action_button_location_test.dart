import 'package:flutter/material.dart';

/// Deep visual demo for FloatingActionButtonLocation.
/// Shows the abstract class defining FAB positioning.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FloatingActionButtonLocation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 12),
      Container(
        width: 260,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Grid of possible locations
            ..._buildLocationDots(),
            // Legend
            Positioned(
              bottom: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('• centerFloat', style: TextStyle(fontSize: 8)),
                  Text('• endFloat', style: TextStyle(fontSize: 8)),
                  Text('• *Docked variants', style: TextStyle(fontSize: 8)),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Text('getOffset(context, fabSize, scaffold)', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
      ),
    ],
  );
}

List<Widget> _buildLocationDots() {
  final positions = [
    (0.5, 0.85, 'centerFloat', true),
    (0.85, 0.85, 'endFloat', true),
    (0.15, 0.85, 'startFloat', false),
    (0.85, 0.15, 'startTop', false),
    (0.5, 0.5, 'mini locations', false),
  ];
  return positions.map((p) {
    return Positioned(
      left: 260 * p.$1 - 12,
      top: 160 * p.$2 - 12,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: p.$4 ? Colors.pink : Colors.pink.shade200,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 12),
      ),
    );
  }).toList();
}
