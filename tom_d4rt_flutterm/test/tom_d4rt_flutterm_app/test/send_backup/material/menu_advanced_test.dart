import 'package:flutter/material.dart';

/// Deep visual demo for advanced menu features.
/// Shows nested menus, separators, and checkmarks.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Advanced Menu Features', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MenuItem('New', icon: Icons.add),
            _MenuItem('Open', icon: Icons.folder_open),
            _MenuDivider(),
            _MenuItem('Recent', trailing: Icons.arrow_right, hasSubmenu: true),
            _MenuDivider(),
            _MenuItem('Auto-save', checked: true),
            _MenuItem('Spell Check', checked: false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Nested menus, dividers, checks', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MenuItem extends StatelessWidget {
  final String label;
  final IconData? icon;
  final IconData? trailing;
  final bool? checked;
  final bool hasSubmenu;
  const _MenuItem(this.label, {this.icon, this.trailing, this.checked, this.hasSubmenu = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          if (checked != null) Icon(checked! ? Icons.check : null, size: 16, color: Colors.blue),
          if (checked != null) const SizedBox(width: 8),
          if (icon != null) Icon(icon, size: 16, color: Colors.grey),
          if (icon != null) const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          if (trailing != null) Icon(trailing, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Divider(height: 1);
}
