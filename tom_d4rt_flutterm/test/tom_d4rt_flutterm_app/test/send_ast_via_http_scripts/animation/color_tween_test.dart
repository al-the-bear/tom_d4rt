import 'package:flutter/material.dart';

/// Demonstrates ColorTween - interpolates between two colors.
dynamic build(BuildContext context) {
  final tween = ColorTween(begin: Colors.blue, end: Colors.orange);

  return TweenAnimationBuilder<Color?>(
    tween: tween,
    duration: const Duration(seconds: 3),
    builder: (context, color, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('ColorTween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                child: const Center(child: Text('Begin', style: TextStyle(color: Colors.white, fontSize: 9)))),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward),
              const SizedBox(width: 8),
              Container(width: 80, height: 80, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: color!.withOpacity(0.5), blurRadius: 12)]),
                child: const Center(child: Text('Current', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward),
              const SizedBox(width: 8),
              Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                child: const Center(child: Text('End', style: TextStyle(color: Colors.white, fontSize: 9)))),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 20, width: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple, Colors.orange]),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Interpolates through color space', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}
