import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoColors secondary variants.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Secondary Colors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      const Wrap(
        spacing: 8, runSpacing: 8,
        children: [
          _ColorPair('systemGrey', CupertinoColors.systemGrey, CupertinoColors.systemGrey2),
          _ColorPair('systemGrey3', CupertinoColors.systemGrey3, CupertinoColors.systemGrey4),
          _ColorPair('systemGrey5', CupertinoColors.systemGrey5, CupertinoColors.systemGrey6),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Greys for backgrounds and separators', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _ColorPair extends StatelessWidget {
  final String name; final Color c1, c2;
  const _ColorPair(this.name, this.c1, this.c2);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: c1, borderRadius: BorderRadius.circular(8))),
          const SizedBox(width: 2),
          Container(width: 40, height: 40, decoration: BoxDecoration(color: c2, borderRadius: BorderRadius.circular(8))),
        ],
      ),
      Text(name, style: const TextStyle(fontSize: 9)),
    ],
  );
}
