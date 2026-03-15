import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoApp - iOS application widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoApp', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 200, height: 140,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(16), border: Border.all(color: CupertinoColors.systemGrey4, width: 2)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Container(height: 20, color: CupertinoColors.systemGrey5, child: const Row(children: [SizedBox(width: 8), Text('9:41', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), Spacer()])),
            const Expanded(child: Center(child: Text('CupertinoApp', style: TextStyle(fontFamily: 'monospace', fontSize: 11)))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Root widget for iOS apps', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
