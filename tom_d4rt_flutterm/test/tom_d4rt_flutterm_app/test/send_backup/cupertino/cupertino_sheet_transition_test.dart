import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoSheetTransition - sheet animation.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Sheet Transition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60, height: 100,
            decoration: BoxDecoration(color: CupertinoColors.systemGrey5, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Icon(CupertinoIcons.arrow_up),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('→', style: TextStyle(fontSize: 20)),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 60, height: 100,
                decoration: BoxDecoration(color: CupertinoColors.systemGrey5, borderRadius: BorderRadius.circular(8)),
              ),
              Container(
                width: 60, height: 60,
                decoration: const BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Slide up animation from bottom', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
