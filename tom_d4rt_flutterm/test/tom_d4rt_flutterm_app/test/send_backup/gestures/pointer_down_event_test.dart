import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerDownEvent.
/// Shows when a touch contact begins.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerDownEvent')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Down Event',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue)),
            child: Stack(children: [
              const Center(child: Text('Touch to generate PointerDownEvent', style: TextStyle(color: Colors.blue))),
              Positioned(
                left: 60, top: 60,
                child: Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.3), shape: BoxShape.circle, border: Border.all(color: Colors.blue, width: 3)),
                  child: const Icon(Icons.touch_app, color: Colors.blue),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• position - screen position'),
                Text('• localPosition - widget position'),
                Text('• pressure - touch pressure'),
                Text('• buttons - which button pressed'),
                Text('• kind - device type (touch, mouse, stylus)'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
