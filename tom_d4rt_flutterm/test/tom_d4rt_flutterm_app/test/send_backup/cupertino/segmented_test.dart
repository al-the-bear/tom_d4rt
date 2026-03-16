import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoSegmentedControl.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SegmentedControl', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      CupertinoSegmentedControl<int>(
        groupValue: 0,
        children: const {
          0: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Day')),
          1: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Week')),
          2: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Month')),
        },
        onValueChanged: (v) {},
      ),
      const SizedBox(height: 16),
      CupertinoSlidingSegmentedControl<int>(
        groupValue: 0,
        children: const {0: Text('List'), 1: Text('Grid')},
        onValueChanged: (v) {},
      ),
      const SizedBox(height: 12),
      const Text('Rounded (top) vs Sliding (bottom)', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
