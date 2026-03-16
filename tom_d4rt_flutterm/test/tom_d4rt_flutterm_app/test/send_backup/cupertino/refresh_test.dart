import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoSliverRefreshControl.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Sliver Refresh Control', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 180, height: 130,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: const Column(children: [
                CupertinoActivityIndicator(),
                SizedBox(height: 4),
                Text('Refreshing...', style: TextStyle(fontSize: 11)),
              ]),
            ),
            Container(height: 1, color: CupertinoColors.separator),
            const Padding(padding: EdgeInsets.all(8), child: Text('List content', style: TextStyle(fontSize: 12))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Pull down to trigger refresh', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
