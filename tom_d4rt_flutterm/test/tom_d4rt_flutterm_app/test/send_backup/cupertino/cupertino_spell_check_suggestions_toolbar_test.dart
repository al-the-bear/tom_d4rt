import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoSpellCheckSuggestionsToolbar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Spell Check Toolbar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(blurRadius: 8, color: Color(0x22000000))]),
        child: Column(
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('hte', style: TextStyle(color: CupertinoColors.destructiveRed, decoration: TextDecoration.underline)),
                SizedBox(width: 8),
                Icon(CupertinoIcons.arrow_right, size: 14),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['the', 'he', 'hate'].map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(4)),
                child: Text(s, style: const TextStyle(color: CupertinoColors.white, fontSize: 11)),
              )).toList(),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Offers spelling corrections', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
