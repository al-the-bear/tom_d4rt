import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoButton - iOS-styled button with press effects.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoButton Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      CupertinoButton(
        color: CupertinoColors.activeBlue,
        onPressed: () {},
        child: const Text('Filled Button'),
      ),
      const SizedBox(height: 12),
      CupertinoButton(
        onPressed: () {},
        child: const Text('Plain Button'),
      ),
      const SizedBox(height: 12),
      const CupertinoButton(
        onPressed: null,
        child: Text('Disabled'),
      ),
      const SizedBox(height: 12),
      const Text('iOS-style with press opacity', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
