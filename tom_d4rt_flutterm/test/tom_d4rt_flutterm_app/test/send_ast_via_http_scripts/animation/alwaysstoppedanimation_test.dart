import 'package:flutter/material.dart';

/// Demonstrates AlwaysStoppedAnimation - an animation frozen at a specific value.
/// Useful for passing constant animation values to widgets that expect Animation<T>.
dynamic build(BuildContext context) {
  const opacity70 = AlwaysStoppedAnimation<double>(0.7);
  const scaleFixed = AlwaysStoppedAnimation<double>(1.3);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AlwaysStoppedAnimation Demo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // Using with FadeTransition - shows constant opacity
      FadeTransition(
        opacity: opacity70,
        child: Container(
          width: 120, height: 60,
          color: Colors.indigo,
          alignment: Alignment.center,
          child: const Text('Opacity: 0.7', style: TextStyle(color: Colors.white)),
        ),
      ),
      const SizedBox(height: 16),
      // Using with ScaleTransition - shows constant scale
      ScaleTransition(
        scale: scaleFixed,
        child: Container(
          width: 50, height: 50,
          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: const Text('1.3x', style: TextStyle(fontSize: 11, color: Colors.white)),
        ),
      ),
      const SizedBox(height: 16),
      // Multiple fixed opacity values side by side
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final v in [0.25, 0.5, 0.75, 1.0])
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FadeTransition(
                opacity: AlwaysStoppedAnimation<double>(v),
                child: Container(
                  width: 40, height: 40, color: Colors.teal,
                  alignment: Alignment.center,
                  child: Text('${(v * 100).toInt()}%', style: const TextStyle(color: Colors.white, fontSize: 9)),
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: 8),
      const Text('Use when AnimationController is overkill', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
