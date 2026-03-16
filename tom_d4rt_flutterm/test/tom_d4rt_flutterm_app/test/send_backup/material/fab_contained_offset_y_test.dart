import 'package:flutter/material.dart';

/// Deep visual demo for FabContainedOffsetY - mixin for FAB contained in BottomAppBar.
/// Shows FAB embedded within the bottom app bar notch.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FabContainedOffsetY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
            // Bottom app bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
              ),
            ),
            // FAB (contained = inside bar)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('FAB fully inside BottomAppBar', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
