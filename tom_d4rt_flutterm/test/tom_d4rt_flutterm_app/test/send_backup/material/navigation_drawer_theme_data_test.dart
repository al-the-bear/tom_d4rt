import 'package:flutter/material.dart';

/// Deep visual demo for NavigationDrawerThemeData.
/// Configures visual properties of NavigationDrawer.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('NavigationDrawerThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 200,
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: const Text('Navigation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            _DrawerItem(Icons.dashboard, 'Dashboard', true, Colors.blue),
            _DrawerItem(Icons.inbox, 'Inbox', false, Colors.blue),
            _DrawerItem(Icons.settings, 'Settings', false, Colors.blue),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('backgroundColor, indicatorColor, iconTheme', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Color accent;
  const _DrawerItem(this.icon, this.label, this.selected, this.accent);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? accent.withAlpha(50) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: selected ? accent : Colors.grey),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 11, color: selected ? accent : Colors.grey)),
        ],
      ),
    );
  }
}
