import 'package:flutter/material.dart';

/// Deep visual demo for Material TextStyle usage.
/// Typography styles in Material Design.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextStyle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Display', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
            const Text('Headline', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Text('Title', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const Text('Body Text', style: TextStyle(fontSize: 12)),
            Text('Label', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StyleProp('fontSize'),
          _StyleProp('fontWeight'),
          _StyleProp('color'),
          _StyleProp('letterSpacing'),
        ],
      ),
    ],
  );
}

class _StyleProp extends StatelessWidget {
  final String name;
  const _StyleProp(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
      child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 8)),
    );
  }
}
