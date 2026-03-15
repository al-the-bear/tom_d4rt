import 'package:flutter/cupertino.dart';

/// Deep visual demo for CupertinoAdaptiveTextSelectionToolbar - iOS text selection actions.
/// Demonstrates context menu with cut, copy, paste, and select all actions.
dynamic build(BuildContext context) {
  return CupertinoPageScaffold(
    navigationBar: const CupertinoNavigationBar(
      middle: Text('Selection Toolbar Demo'),
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'CupertinoAdaptiveTextSelectionToolbar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'The toolbar adapts to the platform and provides text editing actions.',
              style: TextStyle(color: CupertinoColors.secondaryLabel),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: CupertinoColors.systemGrey4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Toolbar Actions:', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  _buildActionRow(CupertinoIcons.scissors, 'Cut', 'Remove selected text'),
                  const SizedBox(height: 12),
                  _buildActionRow(CupertinoIcons.doc_on_doc, 'Copy', 'Copy to clipboard'),
                  const SizedBox(height: 12),
                  _buildActionRow(CupertinoIcons.doc_on_clipboard, 'Paste', 'Paste from clipboard'),
                  const SizedBox(height: 12),
                  _buildActionRow(CupertinoIcons.textformat_size, 'Select All', 'Select all text'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Try selecting text below:', style: TextStyle(color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: TextEditingController(text: 'Select this text to see the toolbar'),
              maxLines: 3,
              padding: const EdgeInsets.all(12),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildActionRow(IconData icon, String title, String subtitle) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: CupertinoColors.systemIndigo.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: CupertinoColors.systemIndigo),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
          ],
        ),
      ),
    ],
  );
}
