import 'package:flutter/material.dart';

/// Deep visual demo for DialogThemeData - theme data for dialogs.
/// Shows configurable styling properties for dialog appearance.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DialogThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _DialogPreview('Default', Colors.white, Colors.black, 16),
          const SizedBox(width: 12),
          _DialogPreview('Custom', Colors.indigo.shade50, Colors.indigo, 24),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme Properties:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            Text('• backgroundColor', style: TextStyle(fontSize: 10)),
            Text('• elevation', style: TextStyle(fontSize: 10)),
            Text('• shape', style: TextStyle(fontSize: 10)),
            Text('• titleTextStyle', style: TextStyle(fontSize: 10)),
            Text('• contentTextStyle', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    ],
  );
}

class _DialogPreview extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final double radius;
  const _DialogPreview(this.label, this.bg, this.fg, this.radius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Center(child: Text('Content', style: TextStyle(color: fg, fontSize: 11))),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
