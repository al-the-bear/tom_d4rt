import 'package:flutter/material.dart';

/// Deep visual demo for InteractiveInkFeatureFactory.
/// Shows factory for creating ink splash/ripple effects.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('InteractiveInkFeatureFactory', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _InkDemo('Splash', Colors.blue),
          const SizedBox(width: 16),
          _InkDemo('Ripple', Colors.purple),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Column(
          children: [
            Text('InkSplash.splashFactory', style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
            Text('InkRipple.splashFactory', style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
          ],
        ),
      ),
    ],
  );
}

class _InkDemo extends StatelessWidget {
  final String type;
  final Color color;
  const _InkDemo(this.type, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(100),
                  shape: BoxShape.circle,
                ),
              ),
              const Icon(Icons.touch_app, color: Colors.white),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(type, style: TextStyle(fontSize: 10, color: color)),
      ],
    );
  }
}
