import 'package:flutter/material.dart';

/// Deep visual demo for NavigationRailLabelType enum.
/// Controls label visibility on NavigationRail.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('NavigationRailLabelType', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _RailDemo('none', false, false),
          const SizedBox(width: 16),
          _RailDemo('selected', false, true),
          const SizedBox(width: 16),
          _RailDemo('all', true, true),
        ],
      ),
      const SizedBox(height: 12),
      const Text('labelType property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _RailDemo extends StatelessWidget {
  final String label;
  final bool showUnselected;
  final bool showSelected;
  const _RailDemo(this.label, this.showUnselected, this.showSelected);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              _RailItem(Icons.home, 'Home', true, showSelected),
              const SizedBox(height: 8),
              _RailItem(Icons.search, 'Search', false, showUnselected),
              const SizedBox(height: 8),
              _RailItem(Icons.person, 'Profile', false, showUnselected),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class _RailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final bool showLabel;
  const _RailItem(this.icon, this.label, this.selected, this.showLabel);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: selected ? Colors.blue.withAlpha(50) : null, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, size: 18, color: selected ? Colors.blue : Colors.grey),
        ),
        if (showLabel) Text(label, style: TextStyle(fontSize: 7, color: selected ? Colors.blue : Colors.grey)),
      ],
    );
  }
}
