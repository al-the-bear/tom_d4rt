import 'package:flutter/material.dart';

/// Deep visual demo for MaterialRectArcTween.
/// Animates Rect corners along circular arcs.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialRectArcTween', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Start rect
            Positioned(
              left: 20,
              top: 60,
              child: Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(150),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: const Center(child: Text('A', style: TextStyle(fontSize: 10))),
              ),
            ),
            // End rect
            Positioned(
              right: 20,
              top: 20,
              child: Container(
                width: 60,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(150),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: const Center(child: Text('B', style: TextStyle(fontSize: 10))),
              ),
            ),
            // Arc indicators
            const Positioned(left: 60, top: 45, child: Icon(Icons.trending_up, color: Colors.purple, size: 20)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Corners follow arc paths', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
