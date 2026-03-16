import 'package:flutter/material.dart';

/// Deep visual demo for DesktopTextSelectionControls - desktop text selection toolbar.
/// Shows copy/cut/paste/select all controls for desktop platforms.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Desktop Text Selection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      // Desktop toolbar mockup
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Text field with selection
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Text('Hello '),
                  Container(
                    color: Colors.blue.shade200,
                    child: const Text('selected text'),
                  ),
                  const Text(' world'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Toolbar
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ToolbarButton('Cut'),
                  _ToolbarButton('Copy'),
                  _ToolbarButton('Paste'),
                  _ToolbarButton('Select All'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Desktop-specific text controls', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ToolbarButton extends StatelessWidget {
  final String label;
  const _ToolbarButton(this.label);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }
}
