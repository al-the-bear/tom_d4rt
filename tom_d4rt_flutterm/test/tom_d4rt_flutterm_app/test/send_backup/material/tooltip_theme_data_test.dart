import 'package:flutter/material.dart';

/// Deep visual demo for TooltipThemeData.
/// Theme customization for tooltips.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TooltipThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TooltipTheme('Default', Colors.grey.shade800, Colors.white, 4),
          const SizedBox(width: 16),
          _TooltipTheme('Custom', Colors.blue.shade700, Colors.white, 12),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: [
          _PropChip('height'),
          _PropChip('padding'),
          _PropChip('textStyle'),
          _PropChip('decoration'),
          _PropChip('waitDuration'),
        ],
      ),
    ],
  );
}

class _TooltipTheme extends StatelessWidget {
  final String name;
  final Color bg;
  final Color text;
  final double radius;
  const _TooltipTheme(this.name, this.bg, this.text, this.radius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(radius)),
          child: Text('Tooltip', style: TextStyle(color: text, fontSize: 11)),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 9)),
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
