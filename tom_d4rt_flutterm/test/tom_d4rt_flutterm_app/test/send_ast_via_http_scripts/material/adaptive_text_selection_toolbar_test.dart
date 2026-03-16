import 'package:flutter/material.dart';

/// Deep visual demo for AdaptiveTextSelectionToolbar.
/// Shows platform-adaptive text selection toolbar.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AdaptiveTextSelectionToolbar')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select text below:', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          const SelectableText(
            'This is selectable text. Long press or double-tap to select, '
            'then see the adaptive toolbar with cut, copy, paste options.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Adapts to platform:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• Android/Fuchsia: Material-style'),
                Text('• iOS/macOS: Cupertino-style'),
                Text('• Desktop: Buttons for cut/copy/paste/select all'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
