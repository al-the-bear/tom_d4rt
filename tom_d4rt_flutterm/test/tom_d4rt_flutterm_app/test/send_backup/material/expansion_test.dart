import 'package:flutter/material.dart';

/// Deep visual demo for ExpansionPanel - a single expandable panel.
/// Shows panel header, body, and expand/collapse behavior.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ExpansionPanel Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Panel Header', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Subtitle or summary', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.expand_more, color: Colors.grey.shade600),
                ],
              ),
            ),
            // Expanded body
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: const Text('This is the expanded body content. It reveals more details when the panel is expanded.', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('isExpanded toggles visibility', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
