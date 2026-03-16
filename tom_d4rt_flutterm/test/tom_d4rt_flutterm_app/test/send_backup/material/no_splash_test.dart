import 'package:flutter/material.dart';

/// Deep visual demo for NoSplash class.
/// Ink splash factory that produces no splash effect.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('NoSplash', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SplashDemo('With Splash', true),
          const SizedBox(width: 24),
          _SplashDemo('No Splash', false),
        ],
      ),
      const SizedBox(height: 12),
      const Text('splashFactory: NoSplash.splashFactory', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _SplashDemo extends StatelessWidget {
  final String label;
  final bool hasSplash;
  const _SplashDemo(this.label, this.hasSplash);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.touch_app, color: Colors.blue),
              if (hasSplash)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withAlpha(50)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
