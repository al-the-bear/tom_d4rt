import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for BaseTapAndDragGestureRecognizer.
/// Shows combined tap and drag gesture recognition.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BaseTapAndDragGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tap and Drag Combined',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue)),
            child: const Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.touch_app, size: 48, color: Colors.blue),
                SizedBox(height: 8),
                Text('Tap or Drag Here'),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          _StateRow(state: 'Tap', icon: Icons.touch_app),
          _StateRow(state: 'Tap + Hold', icon: Icons.pan_tool),
          _StateRow(state: 'Tap + Drag', icon: Icons.open_with),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Base class for recognizers that detect both tap and drag from the same initial touch.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _StateRow extends StatelessWidget {
  final String state;
  final IconData icon;
  const _StateRow({required this.state, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 12),
        Text(state, style: const TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
