import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoThumbPainter - slider/switch thumb rendering.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoThumbPainter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: CupertinoColors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 36, height: 22,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(11),
              boxShadow: [BoxShadow(color: CupertinoColors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Shadow + rounded thumb style', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
