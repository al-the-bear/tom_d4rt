import 'package:flutter/material.dart';

/// Deep visual demo for Ink decoration.
/// Shows how Ink provides decoration that responds to gestures.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Ink Decoration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: NetworkImage('https://picsum.photos/200/120'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Stack(
          children: [
            // Ripple effect indicator
            Positioned(
              top: 40,
              left: 60,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(100),
                ),
              ),
            ),
            const Center(
              child: Text('Tap here', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 4)])),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Ink respects Material clip + ripples', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
