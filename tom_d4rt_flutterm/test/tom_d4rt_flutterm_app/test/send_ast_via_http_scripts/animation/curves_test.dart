import 'package:flutter/material.dart';

/// Demonstrates Curves - a collection of predefined animation curves.
dynamic build(BuildContext context) {
  final curves = [
    ('linear', Curves.linear),
    ('ease', Curves.ease),
    ('easeIn', Curves.easeIn),
    ('easeOut', Curves.easeOut),
    ('easeInOut', Curves.easeInOut),
    ('bounceOut', Curves.bounceOut),
    ('elasticOut', Curves.elasticOut),
    ('fastOutSlowIn', Curves.fastOutSlowIn),
  ];

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Curves Collection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8, runSpacing: 8,
        children: [
          for (final (name, curve) in curves)
            _CurveChip(name, curve),
        ],
      ),
      const SizedBox(height: 12),
      const Text('50+ predefined curves in Flutter', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _CurveChip extends StatelessWidget {
  final String name; final Curve curve;
  const _CurveChip(this.name, this.curve);
  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    curve: curve,
    builder: (context, value, _) => Container(
      width: 80, padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1 + value * 0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue)),
      child: Column(
        children: [
          Text(name, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
          LinearProgressIndicator(value: value, minHeight: 4),
        ],
      ),
    ),
  );
}
