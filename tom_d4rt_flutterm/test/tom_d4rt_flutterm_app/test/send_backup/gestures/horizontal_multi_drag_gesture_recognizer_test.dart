import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for HorizontalMultiDragGestureRecognizer.
/// Shows horizontal multi-pointer drag recognition.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('HorizontalMultiDragGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Horizontal Multi-Drag',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 150,
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.arrow_back, color: Colors.green),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.swipe, color: Colors.green, size: 48),
                  SizedBox(height: 8),
                  Text('Drag Horizontally'),
                ]),
                Icon(Icons.arrow_forward, color: Colors.green),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _FeatureRow(icon: Icons.touch_app, text: 'Tracks multiple pointers simultaneously'),
          _FeatureRow(icon: Icons.swap_horiz, text: 'Only responds to horizontal movement'),
          _FeatureRow(icon: Icons.lock_outline, text: 'Ignores vertical component'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Useful for horizontal scrolling or paging that needs to track multiple fingers.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(icon, color: Colors.green, size: 18),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ]),
    );
  }
}
