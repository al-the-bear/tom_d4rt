import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoSliverNavigationBar - large title nav bar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SliverNavigationBar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 280, height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey4),
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: CupertinoColors.systemGrey6,
              child: const Row(
                children: [
                  Icon(CupertinoIcons.back, size: 20),
                  Spacer(),
                  Icon(CupertinoIcons.ellipsis, size: 20),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Align(alignment: Alignment.centerLeft, child: Text('Large Title', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Collapses to small title on scroll', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
