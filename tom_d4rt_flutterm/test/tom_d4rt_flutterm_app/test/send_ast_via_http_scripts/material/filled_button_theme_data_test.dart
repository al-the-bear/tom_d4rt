import 'package:flutter/material.dart';

/// Deep visual demo for FilledButtonThemeData.
/// Shows themed filled button styles.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FilledButtonThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Default
            _FilledButtonPreview('Default', Colors.blue, Colors.white, 20.0),
            const SizedBox(height: 12),
            // Custom theme
            _FilledButtonPreview('Themed', Colors.purple, Colors.white, 24.0),
            const SizedBox(height: 12),
            // Another variant
            _FilledButtonPreview('Tonal', Colors.purple.shade100, Colors.purple, 20.0),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('style property controls appearance', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _FilledButtonPreview extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final double radius;
  const _FilledButtonPreview(this.label, this.bg, this.fg, this.radius);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 60, child: Text(label, style: const TextStyle(fontSize: 11))),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(radius)),
            child: Center(child: Text('Submit', style: TextStyle(color: fg, fontWeight: FontWeight.bold, fontSize: 12))),
          ),
        ),
      ],
    );
  }
}
