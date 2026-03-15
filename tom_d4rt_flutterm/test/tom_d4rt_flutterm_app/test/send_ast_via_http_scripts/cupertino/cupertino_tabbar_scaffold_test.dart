import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoTabBar - iOS bottom tab navigation.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoTabBar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 280, height: 150,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Expanded(child: Center(child: Text('Tab Content'))),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                border: Border(top: BorderSide(color: CupertinoColors.systemGrey4)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _TabItem(CupertinoIcons.home, 'Home', true),
                  _TabItem(CupertinoIcons.search, 'Search', false),
                  _TabItem(CupertinoIcons.person, 'Profile', false),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('iOS tab bar with icons + labels', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _TabItem extends StatelessWidget {
  final IconData icon; final String label; final bool active;
  const _TabItem(this.icon, this.label, this.active);
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: active ? CupertinoColors.activeBlue : CupertinoColors.systemGrey, size: 24),
      Text(label, style: TextStyle(fontSize: 10, color: active ? CupertinoColors.activeBlue : CupertinoColors.systemGrey)),
    ],
  );
}
