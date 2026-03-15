import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoPicker - iOS wheel picker.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoPicker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      SizedBox(
        height: 120, width: 200,
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (_) {},
          children: List.generate(10, (i) => Center(child: Text('Item ${i + 1}'))),
        ),
      ),
      const SizedBox(height: 12),
      const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.arrow_up_arrow_down, size: 16),
          SizedBox(width: 4),
          Text('Scroll to select', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
        ],
      ),
    ],
  );
}
