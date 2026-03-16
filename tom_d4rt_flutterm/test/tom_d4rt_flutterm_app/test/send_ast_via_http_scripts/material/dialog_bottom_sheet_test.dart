import 'package:flutter/material.dart';

/// Deep visual demo for Dialog combined with BottomSheet patterns.
/// Shows how dialogs can be combined with bottom sheet behavior.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Dialog & BottomSheet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Dialog
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.layers, color: Colors.blue),
                Text('Dialog', style: TextStyle(fontSize: 11)),
                Text('Center', style: TextStyle(fontSize: 9, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Bottom Sheet
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.vertical_align_bottom, color: Colors.green),
                Text('BottomSheet', style: TextStyle(fontSize: 11)),
                Text('Bottom', style: TextStyle(fontSize: 9, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Dialog: modal, centered\nBottomSheet: anchored to bottom', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
