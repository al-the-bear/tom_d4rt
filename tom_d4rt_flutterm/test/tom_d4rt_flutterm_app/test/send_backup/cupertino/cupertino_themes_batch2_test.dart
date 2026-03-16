import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoThemeData variants and inheritance.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Theme Inheritance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100, padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: CupertinoColors.systemGrey4)),
            child: const Column(children: [Icon(CupertinoIcons.sun_max, color: CupertinoColors.black), Text('Light', style: TextStyle(fontSize: 11))]),
          ),
          const SizedBox(width: 12),
          Container(
            width: 100, padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: CupertinoColors.black, borderRadius: BorderRadius.circular(8)),
            child: const Column(children: [Icon(CupertinoIcons.moon, color: CupertinoColors.white), Text('Dark', style: TextStyle(color: CupertinoColors.white, fontSize: 11))]),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('.copyWith() for variations', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
