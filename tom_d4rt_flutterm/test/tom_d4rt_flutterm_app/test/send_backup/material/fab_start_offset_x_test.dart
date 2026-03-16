import 'package:flutter/material.dart';

/// Deep visual demo for FabStartOffsetX - mixin for start-aligned FAB.
/// Shows FAB positioned at the leading edge.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FabStartOffsetX', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // Start alignment arrow
            const Positioned(
              bottom: 40,
              left: 8,
              child: Icon(Icons.arrow_back, color: Colors.blue, size: 16),
            ),
            // FAB at start
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
            // Label
            const Positioned(
              top: 8,
              right: 8,
              child: Text('offsetX: start', style: TextStyle(fontSize: 9, color: Colors.grey)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Positions FAB at leading edge', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
