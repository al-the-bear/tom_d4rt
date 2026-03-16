import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoTextSelectionHandleControls.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Handle Controls', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 2, height: 30, decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(1))),
                Container(
                  width: 12, height: 12, margin: const EdgeInsets.only(left: -7),
                  decoration: const BoxDecoration(color: CupertinoColors.activeBlue, shape: BoxShape.circle),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Touch-friendly handles', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Cursor positioning + selection', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
