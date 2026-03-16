import 'package:flutter/material.dart';

/// Deep visual demo for MenuAcceleratorCallbackBinding.
/// Handles keyboard shortcuts for menu items.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MenuAcceleratorCallback', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _AcceleratorRow('&File', 'Alt+F'),
            _AcceleratorRow('&Edit', 'Alt+E'),
            _AcceleratorRow('&View', 'Alt+V'),
            _AcceleratorRow('&Help', 'Alt+H'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('& marks accelerator key', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _AcceleratorRow extends StatelessWidget {
  final String label;
  final String shortcut;
  const _AcceleratorRow(this.label, this.shortcut);
  @override
  Widget build(BuildContext context) {
    final underlineIndex = label.indexOf('&');
    final cleanLabel = label.replaceAll('&', '');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 12),
              children: [
                TextSpan(text: cleanLabel.substring(0, underlineIndex)),
                TextSpan(text: cleanLabel[underlineIndex], style: const TextStyle(decoration: TextDecoration.underline)),
                TextSpan(text: cleanLabel.substring(underlineIndex + 1)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
            child: Text(shortcut, style: const TextStyle(fontSize: 9, fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }
}
