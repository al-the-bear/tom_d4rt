import 'package:flutter/material.dart';

/// Deep visual demo for NavigationDestination widget.
/// Individual destination in NavigationBar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('NavigationDestination', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _DestinationDemo(Icons.home_outlined, Icons.home, 'Home', false),
          const SizedBox(width: 24),
          _DestinationDemo(Icons.search_outlined, Icons.search, 'Search', true),
          const SizedBox(width: 24),
          _DestinationDemo(Icons.person_outline, Icons.person, 'Profile', false),
        ],
      ),
      const SizedBox(height: 12),
      const Text('icon → selectedIcon transition', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DestinationDemo extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  const _DestinationDemo(this.icon, this.selectedIcon, this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: selected ? Colors.blue.withAlpha(30) : null, borderRadius: BorderRadius.circular(12)),
          child: Icon(selected ? selectedIcon : icon, size: 24, color: selected ? Colors.blue : Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: selected ? Colors.blue : Colors.grey, fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
