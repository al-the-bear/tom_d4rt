import 'package:flutter/material.dart';

/// Demonstrates AnimationStatusListener - callback type for animation status changes.
dynamic build(BuildContext context) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    builder: (context, value, _) {
      final status = value < 0.01 ? 'dismissed' : value > 0.99 ? 'completed' : 'forward';
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('AnimationStatusListener Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Text('typedef AnimationStatusListener =', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                const Text('void Function(AnimationStatus status)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.notifications, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Text('Status: $status', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: value),
        ],
      );
    },
  );
}
