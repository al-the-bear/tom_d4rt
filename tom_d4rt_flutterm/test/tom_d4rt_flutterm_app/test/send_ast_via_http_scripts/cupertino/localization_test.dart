import 'package:flutter/cupertino.dart';

/// Demonstrates DefaultCupertinoLocalizations.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Localizations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Row(mainAxisSize: MainAxisSize.min, children: [Icon(CupertinoIcons.globe), SizedBox(width: 8), Text('en_US')]),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: ['Cut', 'Copy', 'Paste', 'Select All', 'Today', 'Now'].map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(4)),
                child: Text(s, style: const TextStyle(fontSize: 10)),
              )).toList(),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('System strings for iOS widgets', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
