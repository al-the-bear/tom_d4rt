import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoPickerDefaultSelectionOverlay.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Picker Selection Overlay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 200, height: 100,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Item 1', style: TextStyle(color: CupertinoColors.systemGrey2)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey4.withOpacity(0.3),
                    border: Border.symmetric(horizontal: BorderSide(color: CupertinoColors.systemGrey3)),
                  ),
                  child: const Center(child: Text('Item 2', style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                const SizedBox(height: 4),
                Text('Item 3', style: TextStyle(color: CupertinoColors.systemGrey2)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Visual indicator for selected item', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
