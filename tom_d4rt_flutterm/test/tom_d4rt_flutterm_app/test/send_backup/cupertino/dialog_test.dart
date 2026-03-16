import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoAlertDialog.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoAlertDialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 240, padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(14), boxShadow: const [BoxShadow(blurRadius: 20, color: Color(0x33000000))]),
        child: Column(
          children: [
            const Text('Delete File?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('This action cannot be undone.', style: TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: CupertinoButton(padding: EdgeInsets.zero, onPressed: () {}, child: const Text('Cancel'))),
                Container(width: 1, height: 30, color: CupertinoColors.separator),
                Expanded(child: CupertinoButton(padding: EdgeInsets.zero, onPressed: () {}, child: const Text('Delete', style: TextStyle(color: CupertinoColors.destructiveRed)))),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Modal alert with actions', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
