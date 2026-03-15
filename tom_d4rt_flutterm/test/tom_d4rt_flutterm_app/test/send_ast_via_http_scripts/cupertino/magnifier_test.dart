import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoMagnifier.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoMagnifier', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200, height: 60,
            alignment: Alignment.center,
            child: const Text('Sample text to magnify', style: TextStyle(fontSize: 12)),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 80, height: 40,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CupertinoColors.systemGrey4),
                boxShadow: const [BoxShadow(blurRadius: 8, color: Color(0x33000000))],
              ),
              alignment: Alignment.center,
              child: const Text('text', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Loupe for precise text selection', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
