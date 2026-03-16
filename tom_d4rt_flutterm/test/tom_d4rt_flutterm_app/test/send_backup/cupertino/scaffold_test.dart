import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoPageScaffold.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoPageScaffold', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 200, height: 150,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12), border: Border.all(color: CupertinoColors.systemGrey4)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Container(
              height: 44, padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(color: CupertinoColors.systemGrey5, border: Border(bottom: BorderSide(color: CupertinoColors.separator))),
              child: const Row(children: [Icon(CupertinoIcons.back, size: 20), Expanded(child: Text('Title', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))), SizedBox(width: 20)]),
            ),
            const Expanded(child: Center(child: Text('Body content'))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Nav bar + safe area body', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
