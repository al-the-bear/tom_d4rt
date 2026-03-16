import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoTextSelectionControls - text handles/toolbar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Text Selection Controls', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            // Selection handles
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 10, height: 20, decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(5))),
                Container(width: 80, height: 20, color: CupertinoColors.activeBlue.withOpacity(0.3), child: const Center(child: Text('selected', style: TextStyle(fontSize: 11)))),
                Container(width: 10, height: 20, decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(5))),
              ],
            ),
            const SizedBox(height: 12),
            // Toolbar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: CupertinoColors.darkBackgroundGray, borderRadius: BorderRadius.circular(4)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Cut', style: TextStyle(color: CupertinoColors.white, fontSize: 11)),
                  SizedBox(width: 12),
                  Text('Copy', style: TextStyle(color: CupertinoColors.white, fontSize: 11)),
                  SizedBox(width: 12),
                  Text('Paste', style: TextStyle(color: CupertinoColors.white, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Handles + floating toolbar', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
