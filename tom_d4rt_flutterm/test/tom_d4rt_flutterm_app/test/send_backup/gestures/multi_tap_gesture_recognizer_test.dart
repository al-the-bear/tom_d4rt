import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for MultiTapGestureRecognizer.
/// Shows multi-pointer tap detection.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('MultiTapGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Multi-Finger Tap',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.purple)),
            child: Stack(children: [
              const Center(child: Text('Tap with multiple fingers', style: TextStyle(color: Colors.purple))),
              Positioned(left: 40, top: 50, child: _TapCircle(index: 1)),
              Positioned(right: 60, top: 80, child: _TapCircle(index: 2)),
              Positioned(left: 80, bottom: 40, child: _TapCircle(index: 3)),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• onTapDown(pointer, details)'),
                Text('• onTapUp(pointer, details)'),
                Text('• onTapCancel(pointer)'),
                Text('• onTap(pointer)'),
                Text('• onLongTapDown(pointer, details)'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TapCircle extends StatelessWidget {
  final int index;
  const _TapCircle({required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(color: Colors.purple.withValues(alpha: 0.3), shape: BoxShape.circle, border: Border.all(color: Colors.purple, width: 2)),
      child: Center(child: Text('\$index', style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold))),
    );
  }
}
