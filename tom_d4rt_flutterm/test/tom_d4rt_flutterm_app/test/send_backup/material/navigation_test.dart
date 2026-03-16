import 'package:flutter/material.dart';

/// Deep visual demo for navigation components.
/// NavigationBar, NavigationRail, NavigationDrawer.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Navigation Components', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _NavType('Bar', Icons.horizontal_distribute),
          const SizedBox(width: 16),
          _NavType('Rail', Icons.vertical_distribute),
          const SizedBox(width: 16),
          _NavType('Drawer', Icons.menu),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(Icons.home, 'Home', true),
            _NavItem(Icons.search, 'Search', false),
            _NavItem(Icons.notifications, 'Alerts', false),
            _NavItem(Icons.person, 'Profile', false),
          ],
        ),
      ),
    ],
  );
}

class _NavType extends StatelessWidget {
  final String label;
  final IconData icon;
  const _NavType(this.label, this.icon);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.blue),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _NavItem(this.icon, this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: selected ? Colors.blue.withAlpha(50) : null, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, size: 18, color: selected ? Colors.blue : Colors.grey),
        ),
        Text(label, style: TextStyle(fontSize: 8, color: selected ? Colors.blue : Colors.grey)),
      ],
    );
  }
}
