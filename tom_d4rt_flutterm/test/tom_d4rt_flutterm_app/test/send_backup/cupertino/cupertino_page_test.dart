import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoPage - declarative page for Navigator 2.0.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoPage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Navigator 2.0 API', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(8)),
              child: const Text("CupertinoPage(\n  key: ValueKey('home'),\n  child: HomePage(),\n)", style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Declarative routing with iOS transitions', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
