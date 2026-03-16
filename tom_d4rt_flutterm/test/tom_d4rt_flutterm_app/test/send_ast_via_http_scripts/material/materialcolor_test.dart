import 'package:flutter/material.dart';

/// Deep visual demo for MaterialColor class.
/// Shows color with shade variants (50-900).
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialColor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      // Primary color and shades
      Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          _ShadeBox(Colors.blue.shade50, '50'),
          _ShadeBox(Colors.blue.shade100, '100'),
          _ShadeBox(Colors.blue.shade200, '200'),
          _ShadeBox(Colors.blue.shade300, '300'),
          _ShadeBox(Colors.blue.shade400, '400'),
          _ShadeBox(Colors.blue, '500'),
          _ShadeBox(Colors.blue.shade600, '600'),
          _ShadeBox(Colors.blue.shade700, '700'),
          _ShadeBox(Colors.blue.shade800, '800'),
          _ShadeBox(Colors.blue.shade900, '900'),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Colors.blue[500] or Colors.blue.shade500', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _ShadeBox extends StatelessWidget {
  final Color color;
  final String shade;
  const _ShadeBox(this.color, this.shade);
  @override
  Widget build(BuildContext context) {
    final isLight = shade == '50' || shade == '100' || shade == '200';
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      alignment: Alignment.center,
      child: Text(shade, style: TextStyle(fontSize: 8, color: isLight ? Colors.black : Colors.white)),
    );
  }
}
