import 'package:flutter/cupertino.dart';

/// Demonstrates RestorableCupertinoTabController.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Restorable Tab Controller', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Icon(CupertinoIcons.arrow_counterclockwise, size: 32),
            const SizedBox(height: 8),
            const Text('State Restoration', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => Container(
                width: 40, height: 30, margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(color: i == 1 ? CupertinoColors.activeBlue : CupertinoColors.systemGrey4, borderRadius: BorderRadius.circular(4)),
                alignment: Alignment.center,
                child: Text('${i + 1}', style: TextStyle(color: i == 1 ? CupertinoColors.white : CupertinoColors.black, fontSize: 12)),
              )),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Persists selected tab index', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
