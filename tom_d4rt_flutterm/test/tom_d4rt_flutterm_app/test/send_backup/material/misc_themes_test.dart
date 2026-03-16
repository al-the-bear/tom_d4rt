import 'package:flutter/material.dart';

/// Deep visual demo for miscellaneous Material themes.
/// Various theme data classes.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Miscellaneous Themes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _ThemeChip('Divider', Colors.grey),
          _ThemeChip('Scrollbar', Colors.blue),
          _ThemeChip('Tooltip', Colors.orange),
          _ThemeChip('Badge', Colors.red),
          _ThemeChip('Progress', Colors.green),
          _ThemeChip('Expansion', Colors.purple),
        ],
      ),
      const SizedBox(height: 12),
      const Text('All inherit from ThemeExtension', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemeChip extends StatelessWidget {
  final String label;
  final Color color;
  const _ThemeChip(this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withAlpha(30), borderRadius: BorderRadius.circular(16), border: Border.all(color: color)),
      child: Text(label, style: TextStyle(fontSize: 10, color: color)),
    );
  }
}
