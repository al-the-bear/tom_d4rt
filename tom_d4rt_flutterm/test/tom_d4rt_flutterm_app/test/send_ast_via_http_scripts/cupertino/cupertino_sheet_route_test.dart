import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoSheetRoute - iOS modal sheet.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoSheetRoute', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 200, height: 120,
            decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
            child: const Center(child: Text('Background')),
          ),
          Container(
            width: 200, height: 80,
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [BoxShadow(blurRadius: 10, color: Color(0x33000000))],
            ),
            child: Column(
              children: [
                Container(margin: const EdgeInsets.only(top: 8), width: 36, height: 4, decoration: BoxDecoration(color: CupertinoColors.systemGrey4, borderRadius: BorderRadius.circular(2))),
                const Padding(padding: EdgeInsets.all(12), child: Text('Sheet Content', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Drag-dismissible modal sheet', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
