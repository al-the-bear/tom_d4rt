import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoListSection with tiles.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoListSection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      SizedBox(
        width: 260,
        child: CupertinoListSection.insetGrouped(
          children: const [
            CupertinoListTile(leading: Icon(CupertinoIcons.folder), title: Text('Files'), trailing: CupertinoListTileChevron()),
            CupertinoListTile(leading: Icon(CupertinoIcons.doc), title: Text('Documents'), trailing: CupertinoListTileChevron()),
            CupertinoListTile(leading: Icon(CupertinoIcons.cloud), title: Text('Cloud'), trailing: CupertinoListTileChevron()),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('iOS Settings-style list', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
