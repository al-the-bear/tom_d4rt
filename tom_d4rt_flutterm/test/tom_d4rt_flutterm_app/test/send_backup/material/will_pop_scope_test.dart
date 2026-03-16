import 'package:flutter/material.dart';

/// Deep visual demo for WillPopScope widget.
/// DEPRECATED: Intercepts back button press.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('WillPopScope', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(4)),
        child: const Text('DEPRECATED - Use PopScope', style: TextStyle(fontSize: 10, color: Colors.red)),
      ),
      const SizedBox(height: 16),
      Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(color: Colors.blue, borderRadius: const BorderRadius.vertical(top: Radius.circular(7))),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const Row(children: [Icon(Icons.arrow_back, color: Colors.white, size: 16), SizedBox(width: 8), Text('Form', style: TextStyle(color: Colors.white, fontSize: 11))]),
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4)),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning, color: Colors.orange, size: 18),
                      SizedBox(height: 4),
                      Text('Discard?', style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('onWillPop: Future<bool> Function()', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
