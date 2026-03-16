import 'package:flutter/material.dart';

/// Deep visual demo for input themes in Material.
/// Shows various themed input field styles.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Input Themes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _InputStyle('Material 2', Colors.blue, false, false),
      const SizedBox(height: 8),
      _InputStyle('Material 3', Colors.purple, true, false),
      const SizedBox(height: 8),
      _InputStyle('Filled', Colors.grey, false, true),
      const SizedBox(height: 12),
      const Text('Different border and fill styles', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _InputStyle extends StatelessWidget {
  final String label;
  final Color color;
  final bool rounded;
  final bool filled;
  const _InputStyle(this.label, this.color, this.rounded, this.filled);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: filled ? color.withAlpha(30) : null,
        border: filled ? null : Border.all(color: color),
        borderRadius: BorderRadius.circular(rounded ? 20 : 4),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(color: color, fontSize: 12))),
          Icon(Icons.edit, color: color, size: 16),
        ],
      ),
    );
  }
}
