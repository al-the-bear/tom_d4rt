import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoDesktopTextSelectionControls - desktop text selection.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Desktop Text Selection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Icon(CupertinoIcons.cursor_rays, size: 40),
            const SizedBox(height: 8),
            const Text('CupertinoDesktopTextSelectionControls'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(8)),
              child: const Text('Desktop-optimized handles'),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Wrap(
        spacing: 8,
        children: [
          _FeatureChip('Right-click menu'),
          _FeatureChip('Keyboard shortcuts'),
          _FeatureChip('No handles'),
        ],
      ),
    ],
  );
}

class _FeatureChip extends StatelessWidget {
  final String text;
  const _FeatureChip(this.text);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: CupertinoColors.systemGrey5, borderRadius: BorderRadius.circular(8)),
    child: Text(text, style: const TextStyle(fontSize: 10)),
  );
}
