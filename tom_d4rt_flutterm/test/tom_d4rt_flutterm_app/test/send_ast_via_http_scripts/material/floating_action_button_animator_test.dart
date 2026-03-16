import 'package:flutter/material.dart';

/// Deep visual demo for FloatingActionButtonAnimator.
/// Shows animation controller for FAB transitions.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FAB Animator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (i) {
          final progress = i / 4;
          final scale = 0.5 + (progress * 0.5);
          final opacity = progress;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Opacity(
              opacity: opacity.clamp(0.2, 1.0),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4 * progress)],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 16 + (8 * progress)),
                ),
              ),
            ),
          );
        }),
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('0%', style: TextStyle(fontSize: 9, color: Colors.grey)),
          SizedBox(width: 120),
          Text('100%', style: TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      ),
      const SizedBox(height: 8),
      const Text('Animates scale + rotation on location change', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
