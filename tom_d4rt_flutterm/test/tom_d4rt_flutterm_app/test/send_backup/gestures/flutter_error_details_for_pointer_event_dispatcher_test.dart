import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for FlutterErrorDetailsForPointerEventDispatcher.
/// Shows error details specific to pointer event dispatch.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerEventDispatcher Error')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Event Error Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8),
                  Text('FlutterError', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                ]),
                const SizedBox(height: 12),
                const Text('Error during pointer event dispatch', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('event: PointerDownEvent', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
                      Text('hitTestEntry: RenderBox', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Provides additional context about the pointer event and hit test entry when errors occur during event dispatch.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}
