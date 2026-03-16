import 'package:flutter/material.dart';

/// Deep visual demo for MaterialTextSelectionControls.
/// Shows text selection handles and toolbar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialTextSelectionControls', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            // Toolbar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Cut', style: TextStyle(color: Colors.white, fontSize: 10)),
                  SizedBox(width: 12),
                  Text('Copy', style: TextStyle(color: Colors.white, fontSize: 10)),
                  SizedBox(width: 12),
                  Text('Paste', style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Selected text with handles
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 2, height: 20, color: Colors.blue),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  color: Colors.blue.withAlpha(80),
                  child: const Text('Selected', style: TextStyle(fontSize: 14)),
                ),
                Container(width: 2, height: 20, color: Colors.blue),
              ],
            ),
            // Handles
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
                const SizedBox(width: 60),
                Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Handles + toolbar for selection', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
