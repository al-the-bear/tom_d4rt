import 'package:flutter/material.dart';

/// Deep visual demo for DropdownMenuEntry - single entry in DropdownMenu.
/// Shows menu item with value, label, and optional leading widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DropdownMenuEntry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            _MenuEntry(Icons.star, 'Featured', true),
            _MenuEntry(Icons.new_releases, 'New', false),
            _MenuEntry(Icons.trending_up, 'Popular', false),
            _MenuEntry(Icons.local_offer, 'Deals', false),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          children: [
            Text('Entry Properties:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            Text('value, label, leadingIcon, enabled', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
          ],
        ),
      ),
    ],
  );
}

class _MenuEntry extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _MenuEntry(this.icon, this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? Colors.blue.shade50 : Colors.transparent,
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: selected ? Colors.blue : Colors.grey),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: selected ? Colors.blue : Colors.black)),
        ],
      ),
    );
  }
}
