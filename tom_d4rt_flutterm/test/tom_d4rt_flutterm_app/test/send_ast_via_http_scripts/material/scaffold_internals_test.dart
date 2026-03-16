import 'package:flutter/material.dart';

/// Deep visual demo for Scaffold internals.
/// Layout structure and widget composition.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Scaffold Internals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _SlotRow('AppBar', Icons.web_asset, Colors.blue),
            _SlotRow('Body', Icons.crop_square, Colors.green),
            _SlotRow('FAB', Icons.add_circle, Colors.pink),
            _SlotRow('BottomNav', Icons.view_agenda, Colors.orange),
            _SlotRow('Drawer', Icons.menu, Colors.purple),
            _SlotRow('EndDrawer', Icons.menu_open, Colors.teal),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Slots managed by _ScaffoldLayout', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _SlotRow extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  const _SlotRow(this.name, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(name, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}
