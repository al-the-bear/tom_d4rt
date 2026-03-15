import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoLinearActivityIndicator - linear loading bar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Linear Activity Indicator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 24),
      const SizedBox(
        width: 200,
        child: CupertinoActivityIndicator(radius: 14),
      ),
      const SizedBox(height: 24),
      Container(
        width: 200, height: 4,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [CupertinoColors.activeBlue, CupertinoColors.systemPurple]),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(height: 24),
      const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(radius: 10),
          SizedBox(width: 8),
          Text('Loading...', style: TextStyle(fontSize: 12)),
        ],
      ),
      const SizedBox(height: 12),
      const Text('iOS-style progress indication', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}
