import 'package:flutter/material.dart';

/// Deep visual demo for MenuButtonThemeData.
/// Shows themed menu button styling.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MenuButtonThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _ThemedMenuItem('Default', Colors.grey.shade200),
            const SizedBox(height: 8),
            _ThemedMenuItem('Primary', Colors.blue.shade100),
            const SizedBox(height: 8),
            _ThemedMenuItem('Secondary', Colors.purple.shade100),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('style property on MenuItemButton', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemedMenuItem extends StatelessWidget {
  final String label;
  final Color bg;
  const _ThemedMenuItem(this.label, this.bg);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          const Icon(Icons.settings, size: 16),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
