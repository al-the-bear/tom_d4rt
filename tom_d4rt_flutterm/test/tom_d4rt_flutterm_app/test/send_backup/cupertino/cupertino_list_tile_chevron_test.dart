import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoListTileChevron - navigation indicator.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ListTileChevron', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      SizedBox(
        width: 280,
        child: CupertinoListSection.insetGrouped(
          children: const [
            CupertinoListTile(
              title: Text('Settings'),
              leading: Icon(CupertinoIcons.gear),
              trailing: CupertinoListTileChevron(),
            ),
            CupertinoListTile(
              title: Text('Privacy'),
              leading: Icon(CupertinoIcons.lock),
              trailing: CupertinoListTileChevron(),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.chevron_forward, size: 14, color: CupertinoColors.systemGrey),
          SizedBox(width: 4),
          Text('Indicates navigation action', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
        ],
      ),
    ],
  );
}
