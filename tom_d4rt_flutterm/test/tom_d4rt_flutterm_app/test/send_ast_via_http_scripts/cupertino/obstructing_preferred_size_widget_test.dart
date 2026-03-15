import 'package:flutter/cupertino.dart';

/// Demonstrates ObstructingPreferredSizeWidget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ObstructingPreferredSize', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Container(
              height: 44, padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.9),
                border: const Border(bottom: BorderSide(color: CupertinoColors.separator)),
              ),
              child: const Row(children: [Text('Navigation Bar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]),
            ),
            Container(
              height: 60, padding: const EdgeInsets.all(8),
              child: const Text('Content scrolls behind translucent bar', style: TextStyle(fontSize: 10)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Reports if content should avoid nav bar', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
