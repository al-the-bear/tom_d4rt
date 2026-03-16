import 'package:flutter/material.dart';

/// Deep visual demo for IconButtonThemeData.
/// Shows themed icon button styling.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('IconButtonThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _IconButtonPreview('Standard', null),
            _IconButtonPreview('Filled', Colors.blue.shade100),
            _IconButtonPreview('Outlined', null, outlined: true),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('style property controls appearance', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _IconButtonPreview extends StatelessWidget {
  final String label;
  final Color? bg;
  final bool outlined;
  const _IconButtonPreview(this.label, this.bg, {this.outlined = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            border: outlined ? Border.all(color: Colors.grey.shade400) : null,
          ),
          child: const Icon(Icons.favorite, color: Colors.blue),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
