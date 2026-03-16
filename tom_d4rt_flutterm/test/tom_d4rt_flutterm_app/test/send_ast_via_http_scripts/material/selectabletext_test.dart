import 'package:flutter/material.dart';

/// Deep visual demo for SelectableText widget.
/// Text widget that can be selected and copied.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SelectableText', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 12),
                children: [
                  TextSpan(text: 'This is '),
                  TextSpan(text: 'selectable', style: TextStyle(backgroundColor: Color(0x4D2196F3))),
                  TextSpan(text: ' text'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.copy, color: Colors.white, size: 12),
            SizedBox(width: 4),
            Text('Copy', style: TextStyle(color: Colors.white, fontSize: 10)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('showCursor, cursorWidth, cursorColor', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
