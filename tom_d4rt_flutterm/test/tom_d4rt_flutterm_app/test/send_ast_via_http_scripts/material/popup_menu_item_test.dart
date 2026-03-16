import 'package:flutter/material.dart';

/// Deep visual demo for PopupMenuItem widget.
/// Single item in a popup menu.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PopupMenuItem', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 150,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MenuItem('Profile', Icons.person, false),
            _MenuItem('Settings', Icons.settings, true),
            _MenuItem('Logout', Icons.logout, false, enabled: false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('value, enabled, onTap', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool hovered;
  final bool enabled;
  const _MenuItem(this.label, this.icon, this.hovered, {this.enabled = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: hovered ? Colors.grey.shade100 : null,
      child: Row(
        children: [
          Icon(icon, size: 18, color: enabled ? Colors.grey : Colors.grey.shade300),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 12, color: enabled ? Colors.black : Colors.grey.shade400)),
        ],
      ),
    );
  }
}
