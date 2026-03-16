import 'package:flutter/material.dart';

/// Deep visual demo for advanced popup menu features.
/// Nested, checked items, dividers, positioning.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Advanced Popup Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 140,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PopupItem(Icons.cut, 'Cut', null),
            _PopupItem(Icons.copy, 'Copy', null),
            _PopupItem(Icons.paste, 'Paste', null),
            const Divider(height: 1),
            _PopupItem(Icons.check, 'Auto-save', true),
            _PopupItem(null, 'Format', false),
            const Divider(height: 1),
            _PopupItem(null, 'More ►', null, hasSubmenu: true),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Dividers, checks, submenus', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _PopupItem extends StatelessWidget {
  final IconData? leading;
  final String label;
  final bool? checked;
  final bool hasSubmenu;
  const _PopupItem(this.leading, this.label, this.checked, {this.hasSubmenu = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 20, child: checked != null ? Icon(checked! ? Icons.check : null, size: 14, color: Colors.blue) : (leading != null ? Icon(leading, size: 14, color: Colors.grey) : null)),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          if (hasSubmenu) const Icon(Icons.arrow_right, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
