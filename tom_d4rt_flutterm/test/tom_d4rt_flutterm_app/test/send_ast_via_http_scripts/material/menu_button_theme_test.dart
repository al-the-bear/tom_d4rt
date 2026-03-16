import 'package:flutter/material.dart';

/// Deep visual demo for MenuButtonTheme widget.
/// InheritedWidget providing MenuButtonThemeData to descendants.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MenuButtonTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Column(
          children: [
            const Text('Theme Scope', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
            const SizedBox(height: 12),
            Container(
              width: 140,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(4)),
              child: const Row(children: [Icon(Icons.edit, size: 16), SizedBox(width: 8), Text('Edit', style: TextStyle(fontSize: 12))]),
            ),
            const SizedBox(height: 4),
            Container(
              width: 140,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(4)),
              child: const Row(children: [Icon(Icons.delete, size: 16), SizedBox(width: 8), Text('Delete', style: TextStyle(fontSize: 12))]),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Applies theme to all nested menus', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
