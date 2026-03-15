import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoScrollBehavior - iOS scroll physics.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoScrollBehavior', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Bouncing', style: TextStyle(color: CupertinoColors.white, fontSize: 11)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: CupertinoColors.systemPurple, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Deceleration', style: TextStyle(color: CupertinoColors.white, fontSize: 11)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('BouncingScrollPhysics', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Overscroll bounce + iOS momentum', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
