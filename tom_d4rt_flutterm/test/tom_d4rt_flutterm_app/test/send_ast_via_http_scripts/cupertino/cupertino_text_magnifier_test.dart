import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoTextMagnifier - text selection magnifier.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoTextMagnifier', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(8)),
            child: const Text('Select this text to see magnifier', style: TextStyle(fontSize: 12)),
          ),
          Container(
            width: 80, height: 50,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CupertinoColors.systemGrey4),
              boxShadow: const [BoxShadow(blurRadius: 8, color: Color(0x33000000))],
            ),
            alignment: Alignment.center,
            child: const Text('text', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Zooms text under touch point', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
