import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for MultiDragGestureRecognizer.
/// Shows base class for multi-pointer drag.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('MultiDragGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Multi-Pointer Drag',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 150,
            decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _PointerIndicator(index: 1),
                _PointerIndicator(index: 2),
                _PointerIndicator(index: 3),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subclasses:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• ImmediateMultiDragGestureRecognizer'),
                Text('• HorizontalMultiDragGestureRecognizer'),
                Text('• VerticalMultiDragGestureRecognizer'),
                Text('• DelayedMultiDragGestureRecognizer'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Each pointer creates its own Drag object for independent tracking.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _PointerIndicator extends StatelessWidget {
  final int index;
  const _PointerIndicator({required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 48, height: 48,
        decoration: BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
        child: Center(child: Text('\$index', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      const SizedBox(height: 8),
      const Text('Pointer', style: TextStyle(fontSize: 11)),
    ]);
  }
}
