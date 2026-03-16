import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoExpansionTile - expandable list tile iOS style.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoExpansionTile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      SizedBox(
        width: 280,
        child: CupertinoListSection.insetGrouped(
          children: [
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.folder),
              title: const Text('Documents'),
              trailing: const CupertinoListTileChevron(),
            ),
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.photo),
              title: const Text('Photos'),
              trailing: const CupertinoListTileChevron(),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(8)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.chevron_down, size: 16),
            SizedBox(width: 8),
            Text('Tap to expand/collapse', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    ],
  );
}
