import 'package:flutter/material.dart';

/// Demonstrates SizeTween - interpolates between two sizes.
dynamic build(BuildContext context) {
  final tween = SizeTween(begin: const Size(50, 50), end: const Size(200, 120));

  return TweenAnimationBuilder<Size?>(
    tween: tween,
    duration: const Duration(seconds: 2),
    builder: (context, size, _) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('SizeTween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          width: size!.width, height: size.height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.purple, Colors.blue]),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text('${size.width.toInt()} x ${size.height.toInt()}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 50, height: 50, decoration: BoxDecoration(border: Border.all(color: Colors.purple), borderRadius: BorderRadius.circular(4)),
              child: const Center(child: Text('Begin', style: TextStyle(fontSize: 8)))),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward),
            const SizedBox(width: 8),
            Container(width: 60, height: 36, decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
              child: const Center(child: Text('End', style: TextStyle(fontSize: 8)))),
          ],
        ),
      ],
    ),
  );
}
