import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoPageRoute - iOS page transition.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoPageRoute', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80, height: 120,
            decoration: BoxDecoration(color: CupertinoColors.systemGrey5, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Text('Page A', style: TextStyle(fontSize: 10)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Icon(CupertinoIcons.arrow_right, color: CupertinoColors.activeBlue),
                Text('slide', style: TextStyle(fontSize: 9)),
              ],
            ),
          ),
          Container(
            width: 80, height: 120,
            decoration: BoxDecoration(color: CupertinoColors.activeBlue.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Text('Page B', style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Horizontal slide with parallax', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
      const SizedBox(height: 8),
      const Text('Back swipe gesture supported', style: TextStyle(fontSize: 10, color: CupertinoColors.systemGrey2)),
    ],
  );
}
