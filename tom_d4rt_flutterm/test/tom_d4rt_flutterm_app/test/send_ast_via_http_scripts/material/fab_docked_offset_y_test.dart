import 'package:flutter/material.dart';

/// Deep visual demo for FabDockedOffsetY - mixin for docked FAB position.
/// Shows FAB half-embedded in BottomAppBar notch.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FabDockedOffsetY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
            // FAB (docked = half in, half out)
            Positioned(
              bottom: 28,
              left: 0,
              right: 0,
              child: Center(
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
            ),
            // Notch indicator
            const Positioned(
              top: 8,
              left: 8,
              child: Text('Docked (notched)', style: TextStyle(fontSize: 9, color: Colors.grey)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('FAB 50% inside bar (with notch)', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
