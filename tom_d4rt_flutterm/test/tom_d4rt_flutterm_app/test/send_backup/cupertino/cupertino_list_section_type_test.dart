import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoListSectionType - grouped vs insetGrouped.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ListSectionType', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              const Text('base', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Container(
                width: 100, height: 80,
                decoration: BoxDecoration(border: Border.all(color: CupertinoColors.systemGrey4)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container(height: 20, color: CupertinoColors.white), Container(height: 1, color: CupertinoColors.separator), Container(height: 20, color: CupertinoColors.white)],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              const Text('insetGrouped', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Container(
                width: 100, height: 80,
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const SizedBox(height: 18), Container(height: 1, margin: const EdgeInsets.only(left: 10), color: CupertinoColors.separator), const SizedBox(height: 18)],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('base: full width, inset: rounded margins', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
