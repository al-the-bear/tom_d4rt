import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoIcons.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoIcons', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      const Wrap(
        spacing: 12, runSpacing: 12,
        children: [
          _IconDemo(CupertinoIcons.home, 'home'),
          _IconDemo(CupertinoIcons.search, 'search'),
          _IconDemo(CupertinoIcons.person, 'person'),
          _IconDemo(CupertinoIcons.gear, 'gear'),
          _IconDemo(CupertinoIcons.bell, 'bell'),
          _IconDemo(CupertinoIcons.heart, 'heart'),
          _IconDemo(CupertinoIcons.star, 'star'),
          _IconDemo(CupertinoIcons.cart, 'cart'),
        ],
      ),
      const SizedBox(height: 12),
      const Text('SF Symbols style iconography', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _IconDemo extends StatelessWidget {
  final IconData icon; final String name;
  const _IconDemo(this.icon, this.name);
  @override
  Widget build(BuildContext context) => Column(
    children: [Icon(icon, size: 28, color: CupertinoColors.activeBlue), Text(name, style: const TextStyle(fontSize: 9))],
  );
}
