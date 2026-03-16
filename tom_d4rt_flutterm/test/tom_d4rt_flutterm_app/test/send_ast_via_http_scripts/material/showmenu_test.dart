import 'package:flutter/material.dart';

/// Deep visual demo for showMenu function.
/// Shows a popup menu at a specified position.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showMenu()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
            child: const Icon(Icons.more_vert, size: 16),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MenuItem(Icons.edit, 'Edit'),
                _MenuItem(Icons.copy, 'Copy'),
                _MenuItem(Icons.share, 'Share'),
                const Divider(height: 1),
                _MenuItem(Icons.delete, 'Delete', isDestructive: true),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('position: RelativeRect', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;
  const _MenuItem(this.icon, this.label, {this.isDestructive = false});
  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red : Colors.black87;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}
