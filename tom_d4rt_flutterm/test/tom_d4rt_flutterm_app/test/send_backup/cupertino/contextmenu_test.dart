import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoContextMenu - iOS context menu with preview.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoContextMenu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      CupertinoContextMenu(
        actions: [
          CupertinoContextMenuAction(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text('Copy'),
          ),
          CupertinoContextMenuAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text('Delete'),
          ),
        ],
        child: Container(
          width: 150, height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [CupertinoColors.activeBlue, CupertinoColors.systemPurple]),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(CupertinoIcons.photo, size: 32, color: CupertinoColors.white), Text('Long press', style: TextStyle(color: CupertinoColors.white, fontSize: 11))],
          ),
        ),
      ),
      const SizedBox(height: 16),
      const Text('Preview + actions on long press', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
