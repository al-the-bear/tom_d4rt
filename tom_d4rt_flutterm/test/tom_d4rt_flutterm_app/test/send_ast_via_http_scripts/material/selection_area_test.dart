import 'package:flutter/material.dart';

/// Deep visual demo for SelectionArea widget.
/// Enables text selection across child widgets.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SelectionArea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: Colors.blue.shade200), borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
              child: const Text('SelectionArea', style: TextStyle(fontSize: 9, color: Colors.blue)),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 11),
                children: [
                  TextSpan(text: 'Title ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'and description ', style: TextStyle(backgroundColor: Color(0x4D2196F3))),
                  TextSpan(text: 'text can be selected together'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('contextMenuBuilder, selectionControls', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
