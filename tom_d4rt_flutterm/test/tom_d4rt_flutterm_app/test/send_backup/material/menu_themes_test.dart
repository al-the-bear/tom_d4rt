import 'package:flutter/material.dart';

/// Deep visual demo for menu theming in Material.
/// Shows various themed menu styles.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Menu Themes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemePreview('Light', Colors.white, Colors.black),
          const SizedBox(width: 16),
          _ThemePreview('Dark', Colors.grey.shade800, Colors.white),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Adapts to ThemeData', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemePreview extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  const _ThemePreview(this.label, this.bg, this.fg);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [Icon(Icons.edit, size: 14, color: fg), const SizedBox(width: 8), Text('Edit', style: TextStyle(color: fg, fontSize: 11))]),
              Divider(color: fg.withAlpha(50)),
              Row(children: [Icon(Icons.copy, size: 14, color: fg), const SizedBox(width: 8), Text('Copy', style: TextStyle(color: fg, fontSize: 11))]),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
