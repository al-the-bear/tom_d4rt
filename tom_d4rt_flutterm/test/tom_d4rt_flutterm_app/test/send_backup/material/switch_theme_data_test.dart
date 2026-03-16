import 'package:flutter/material.dart';

/// Deep visual demo for SwitchThemeData.
/// Theme data for customizing Switch appearance.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SwitchThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThemeSwitch('Default', Colors.blue, Colors.grey.shade400),
          const SizedBox(width: 16),
          _ThemeSwitch('Custom', Colors.purple, Colors.purple.shade200),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: [
          _PropChip('thumbColor'),
          _PropChip('trackColor'),
          _PropChip('trackOutlineColor'),
          _PropChip('overlayColor'),
        ],
      ),
    ],
  );
}

class _ThemeSwitch extends StatelessWidget {
  final String label;
  final Color activeColor;
  final Color inactiveColor;
  const _ThemeSwitch(this.label, this.activeColor, this.inactiveColor);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 26,
          decoration: BoxDecoration(color: activeColor, borderRadius: BorderRadius.circular(13)),
          padding: const EdgeInsets.all(3),
          alignment: Alignment.centerRight,
          child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
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
