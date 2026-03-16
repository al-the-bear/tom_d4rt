import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoTabController.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoTabController', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 250, height: 140,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Expanded(child: Center(child: Text('Tab 1 Content'))),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(color: CupertinoColors.white, border: Border(top: BorderSide(color: CupertinoColors.separator))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Tab(CupertinoIcons.house, 'Home', true),
                  _Tab(CupertinoIcons.search, 'Search', false),
                  _Tab(CupertinoIcons.person, 'Profile', false),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('.index controls active tab', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _Tab extends StatelessWidget {
  final IconData icon; final String label; final bool active;
  const _Tab(this.icon, this.label, this.active);
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: active ? CupertinoColors.activeBlue : CupertinoColors.systemGrey, size: 22),
      Text(label, style: TextStyle(fontSize: 10, color: active ? CupertinoColors.activeBlue : CupertinoColors.systemGrey)),
    ],
  );
}
