import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoPicker wheel selector.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoPicker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        height: 120, width: 180,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (_) {},
          children: List.generate(5, (i) => Center(child: Text('Option ${i + 1}'))),
        ),
      ),
      const SizedBox(height: 12),
      const Text('Scrolling wheel with momentum', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
