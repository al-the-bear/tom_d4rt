import 'package:flutter/material.dart';

/// Deep visual demo for EndDrawerButtonIcon - icon for end drawer.
/// Shows the icon used to toggle the end (right) drawer.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('EndDrawerButtonIcon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Start drawer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Icon(Icons.menu, size: 36),
                SizedBox(height: 8),
                Text('Start', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // End drawer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue),
            ),
            child: const Column(
              children: [
                Icon(Icons.menu_open, size: 36, color: Colors.blue),
                SizedBox(height: 8),
                Text('End', style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Opens drawer from trailing side', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
