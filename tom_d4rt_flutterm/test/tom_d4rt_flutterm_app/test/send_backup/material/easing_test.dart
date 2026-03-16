import 'package:flutter/material.dart';

/// Deep visual demo for Easing - Material 3 easing curves.
/// Shows standardized animation curves for consistent motion.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Easing (Material 3)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _EasingRow('standard', 'Default motion'),
            _EasingRow('standardAccelerate', 'Speed up'),
            _EasingRow('standardDecelerate', 'Slow down'),
            _EasingRow('emphasized', 'Attention-grabbing'),
            _EasingRow('emphasizedAccelerate', 'Emphasized + speed'),
            _EasingRow('emphasizedDecelerate', 'Emphasized + slow'),
            _EasingRow('legacy', 'Material 2 compatibility'),
            _EasingRow('legacyAccelerate', 'Legacy + speed'),
            _EasingRow('legacyDecelerate', 'Legacy + slow'),
          ],
        ),
      ),
    ],
  );
}

class _EasingRow extends StatelessWidget {
  final String name;
  final String desc;
  const _EasingRow(this.name, this.desc);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(4)),
            child: Text(name, style: const TextStyle(fontSize: 9, color: Colors.white, fontFamily: 'monospace')),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(desc, style: const TextStyle(fontSize: 9))),
        ],
      ),
    );
  }
}
