import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerEnterEvent.
/// Shows when pointer enters widget bounds.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerEnterEvent')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Enter Event',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green, width: 2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.login, size: 48, color: Colors.green),
                const SizedBox(height: 12),
                const Text('Mouse Enter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                const SizedBox(height: 8),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.mouse, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  Container(width: 40, height: 2, color: Colors.green),
                  const SizedBox(width: 8),
                  Container(
                    width: 60, height: 40,
                    decoration: BoxDecoration(color: Colors.green.shade200, borderRadius: BorderRadius.circular(4)),
                    child: const Center(child: Text('Widget', style: TextStyle(fontSize: 10))),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.info, color: Colors.blue),
              SizedBox(width: 8),
              Expanded(child: Text('Primarily used for mouse hover effects. Synthesized from hover events.')),
            ]),
          ),
        ],
      ),
    ),
  );
}
