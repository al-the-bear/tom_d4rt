import 'package:flutter/material.dart';

/// Deep visual demo for DesktopTextSelectionToolbar - complete desktop toolbar.
/// Shows the full toolbar with all available actions.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Desktop Selection Toolbar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Selected text indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Selected text here', style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 8),
            // Toolbar popup
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: () {}, child: const Text('Cut')),
                  TextButton(onPressed: () {}, child: const Text('Copy')),
                  TextButton(onPressed: () {}, child: const Text('Paste')),
                  TextButton(onPressed: () {}, child: const Text('Select All')),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Platform-specific toolbar for desktop', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
