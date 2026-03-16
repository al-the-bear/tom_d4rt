import 'package:flutter/material.dart';

/// Deep visual demo for SliderTheme widget.
/// Inherited widget that provides SliderThemeData.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SliderTheme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('SliderTheme.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  const Text('Inherited data:', style: TextStyle(fontSize: 9)),
                  const SizedBox(height: 4),
                  _ThemeRow('thumbColor', Colors.teal),
                  _ThemeRow('activeTrackColor', Colors.teal.shade700),
                  _ThemeRow('overlayColor', Colors.teal.withAlpha(50)),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        width: 180,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 6, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(3))),
            Positioned(left: 0, right: 60, child: Container(height: 6, decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(3)))),
            Positioned(right: 55, child: Container(width: 22, height: 22, decoration: BoxDecoration(color: Colors.teal, shape: BoxShape.circle))),
          ],
        ),
      ),
    ],
  );
}

class _ThemeRow extends StatelessWidget {
  final String prop;
  final Color color;
  const _ThemeRow(this.prop, this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 6),
          Text(prop, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
        ],
      ),
    );
  }
}
