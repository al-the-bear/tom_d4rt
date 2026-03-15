import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoButtonSize enum for button sizing.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoButtonSize', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: CupertinoColors.activeBlue,
        onPressed: () {},
        child: const Text('Large'),
      ),
      const SizedBox(height: 12),
      CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: CupertinoColors.activeBlue,
        onPressed: () {},
        child: const Text('Medium'),
      ),
      const SizedBox(height: 12),
      CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        color: CupertinoColors.activeBlue,
        minSize: 28,
        onPressed: () {},
        child: const Text('Small', style: TextStyle(fontSize: 12)),
      ),
      const SizedBox(height: 12),
      const Text('Control button minSize and padding', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
