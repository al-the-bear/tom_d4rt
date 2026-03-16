import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoSliverRefreshControl - pull-to-refresh.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SliverRefreshControl', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 200, height: 140,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: const Column(
                children: [
                  Icon(CupertinoIcons.arrow_down, color: CupertinoColors.activeBlue),
                  SizedBox(height: 4),
                  CupertinoActivityIndicator(),
                  SizedBox(height: 4),
                  Text('Pull to refresh...', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
            Container(height: 1, color: CupertinoColors.separator),
            const Padding(padding: EdgeInsets.all(8), child: Text('Content here', style: TextStyle(fontSize: 12))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('iOS pull-to-refresh pattern', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
