import 'package:flutter/material.dart';

/// Deep visual demo for ToggleButtonsTheme widget.
/// Inherited widget providing ToggleButtonsThemeData.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ToggleButtonsTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('ToggleButtonsTheme.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ThemeToggle('Default', Colors.blue, 1, 4),
                const SizedBox(width: 16),
                _ThemeToggle('Custom', Colors.teal, 2, 12),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('fillColor, selectedColor, borderRadius', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _ThemeToggle extends StatelessWidget {
  final String name;
  final Color color;
  final double borderWidth;
  final double radius;
  const _ThemeToggle(this.name, this.color, this.borderWidth, this.radius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: color, width: borderWidth), borderRadius: BorderRadius.circular(radius)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: color.withAlpha(75), borderRadius: BorderRadius.horizontal(left: Radius.circular(radius - 1))),
                child: Icon(Icons.star, color: color, size: 14),
              ),
              Container(padding: const EdgeInsets.all(6), child: Icon(Icons.star_border, color: color, size: 14)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
