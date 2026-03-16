import 'package:flutter/material.dart';

/// Deep visual demo for PopupMenuButtonState.
/// State class for PopupMenuButton widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PopupMenuButtonState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('GlobalKey<PopupMenuButtonState>', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.more_vert, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('.showButtonMenu()', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Programmatic menu control', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
