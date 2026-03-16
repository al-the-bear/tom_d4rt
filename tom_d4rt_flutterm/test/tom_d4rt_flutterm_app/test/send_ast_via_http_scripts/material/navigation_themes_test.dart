import 'package:flutter/material.dart';

/// Deep visual demo for navigation theming.
/// Shows themed NavigationBar, Rail, and Drawer.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Navigation Themes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemePreview('Standard', Colors.grey.shade100, Colors.blue),
          const SizedBox(width: 16),
          _ThemePreview('Custom', Colors.purple.shade50, Colors.purple),
        ],
      ),
      const SizedBox(height: 12),
      const Text('NavigationBarThemeData, etc.', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemePreview extends StatelessWidget {
  final String label;
  final Color bg;
  final Color accent;
  const _ThemePreview(this.label, this.bg, this.accent);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: accent.withAlpha(50), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.home, size: 14, color: accent)),
              Icon(Icons.search, size: 14, color: Colors.grey),
              Icon(Icons.person, size: 14, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
