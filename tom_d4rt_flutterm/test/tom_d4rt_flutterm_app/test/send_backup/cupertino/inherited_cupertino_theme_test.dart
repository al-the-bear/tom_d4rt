import 'package:flutter/cupertino.dart';

/// Demonstrates InheritedCupertinoTheme.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('InheritedCupertinoTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Icon(CupertinoIcons.arrow_down, size: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8), padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(8)),
              child: const Column(children: [
                Text('Parent Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                Icon(CupertinoIcons.arrow_down, size: 14),
                Text('Child Widgets', style: TextStyle(fontSize: 10)),
              ]),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Theme propagation via InheritedWidget', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
