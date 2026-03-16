import 'package:flutter/material.dart';

/// Deep visual demo for NavigationDestinationLabelBehavior.
/// Controls label visibility on NavigationBar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('NavigationDestinationLabelBehavior', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _BehaviorRow('alwaysShow', [true, true, true]),
      const SizedBox(height: 8),
      _BehaviorRow('alwaysHide', [false, false, false]),
      const SizedBox(height: 8),
      _BehaviorRow('onlyShowSelected', [false, true, false]),
      const SizedBox(height: 12),
      const Text('labelBehavior property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _BehaviorRow extends StatelessWidget {
  final String label;
  final List<bool> showLabels;
  const _BehaviorRow(this.label, this.showLabels);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 100, child: Text(label, style: const TextStyle(fontSize: 10))),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              _NavItem(Icons.home, 'Home', showLabels[0], false),
              _NavItem(Icons.search, 'Search', showLabels[1], true),
              _NavItem(Icons.person, 'Profile', showLabels[2], false),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool showLabel;
  final bool selected;
  const _NavItem(this.icon, this.label, this.showLabel, this.selected);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Icon(icon, size: 18, color: selected ? Colors.blue : Colors.grey),
          if (showLabel) Text(label, style: TextStyle(fontSize: 8, color: selected ? Colors.blue : Colors.grey)),
        ],
      ),
    );
  }
}
