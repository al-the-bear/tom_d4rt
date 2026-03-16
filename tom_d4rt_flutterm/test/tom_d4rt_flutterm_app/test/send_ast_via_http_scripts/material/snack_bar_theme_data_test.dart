import 'package:flutter/material.dart';

/// Deep visual demo for SnackBarThemeData.
/// Theme data for customizing SnackBar appearance.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SnackBarThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemeSnackBar('Default', Colors.grey.shade800, Colors.white, 4),
          const SizedBox(width: 12),
          _ThemeSnackBar('Custom', Colors.blue.shade700, Colors.white, 16),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: [
          _PropChip('backgroundColor'),
          _PropChip('contentTextStyle'),
          _PropChip('elevation'),
          _PropChip('shape'),
        ],
      ),
    ],
  );
}

class _ThemeSnackBar extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final double radius;
  const _ThemeSnackBar(this.label, this.bgColor, this.textColor, this.radius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(radius)),
          child: Text('Message', style: TextStyle(color: textColor, fontSize: 10)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class _PropChip extends StatelessWidget {
  final String prop;
  const _PropChip(this.prop);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
      child: Text(prop, style: const TextStyle(fontFamily: 'monospace', fontSize: 8)),
    );
  }
}
