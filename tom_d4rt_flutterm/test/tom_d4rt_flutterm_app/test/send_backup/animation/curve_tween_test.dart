import 'package:flutter/material.dart';

/// Demonstrates CurveTween - applies a curve to a 0.0-1.0 animation.
dynamic build(BuildContext context) {
  final curveTween = CurveTween(curve: Curves.easeInOut);

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    builder: (context, linear, _) {
      final curved = curveTween.transform(linear);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('CurveTween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ProgressBar('Linear', linear, Colors.grey),
              const SizedBox(width: 24),
              _ProgressBar('Curved', curved, Colors.purple),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
            child: Text('CurveTween(curve: Curves.easeInOut)', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.purple.shade700)),
          ),
        ],
      );
    },
  );
}

class _ProgressBar extends StatelessWidget {
  final String label; final double value; final Color color;
  const _ProgressBar(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text('${(value * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      const SizedBox(height: 4),
      Container(
        width: 30, height: 100,
        decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(width: 30, height: 100 * value, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10, color: color)),
    ],
  );
}
