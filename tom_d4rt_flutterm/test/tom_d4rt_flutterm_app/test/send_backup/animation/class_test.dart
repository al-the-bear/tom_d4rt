import 'package:flutter/material.dart';

/// Demonstrates basic Dart class concepts used in Flutter animations.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Dart Class Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
        child: const Column(
          children: [
            _ClassBlock('abstract class', 'Animation<T>', 'Base for all animations'),
            SizedBox(height: 8),
            _ClassBlock('mixin', 'AnimationLocalListenersMixin', 'Adds listener management'),
            SizedBox(height: 8),
            _ClassBlock('class', 'AnimationController', 'Concrete implementation'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Flutter animation hierarchy', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ClassBlock extends StatelessWidget {
  final String keyword; final String name; final String desc;
  const _ClassBlock(this.keyword, this.name, this.desc);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(4)),
          child: Text(keyword, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
            Text(desc, style: const TextStyle(fontSize: 9, color: Colors.grey)),
          ],
        ),
      ],
    ),
  );
}
