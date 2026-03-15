import 'package:flutter/cupertino.dart';

/// Demonstrates DefaultCupertinoThemeData.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Default Theme Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('System Defaults', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(width: 150, height: 4, decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8, runSpacing: 4,
              children: [_DefaultChip('SF Pro'), _DefaultChip('Active Blue'), _DefaultChip('System Greys')],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Fallback values when no theme', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _DefaultChip extends StatelessWidget {
  final String text;
  const _DefaultChip(this.text);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: CupertinoColors.systemGrey4, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: const TextStyle(fontSize: 9)),
  );
}
