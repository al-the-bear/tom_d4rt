import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for HitTestDispatcher mixin.
/// Shows how pointer events are dispatched to hit test results.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('HitTestDispatcher')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hit Test Event Dispatch',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Row(children: [
                  Icon(Icons.touch_app, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('Pointer Event', style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 16),
                const Icon(Icons.arrow_downward, color: Colors.orange),
                const SizedBox(height: 8),
                _DispatchStep(text: 'Hit Test Path'),
                _DispatchStep(text: 'Entry 1: GestureDetector'),
                _DispatchStep(text: 'Entry 2: Container'),
                _DispatchStep(text: 'Entry 3: RenderBox'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('HitTestDispatcher.dispatchEvent() sends pointer events to all entries in the hit test path.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _DispatchStep extends StatelessWidget {
  final String text;
  const _DispatchStep({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.orange)),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
