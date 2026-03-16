import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoFocusHalo - focus indicator for accessibility.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoFocusHalo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120, height: 44,
              decoration: BoxDecoration(
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: CupertinoColors.activeBlue.withOpacity(0.4), blurRadius: 8, spreadRadius: 4),
                ],
              ),
              alignment: Alignment.center,
              child: const Text('Focused', style: TextStyle(color: CupertinoColors.white)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Accessibility focus indicator', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
      const SizedBox(height: 8),
      const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.keyboard, size: 16),
          SizedBox(width: 4),
          Text('Tab navigation visibility', style: TextStyle(fontSize: 10)),
        ],
      ),
    ],
  );
}
