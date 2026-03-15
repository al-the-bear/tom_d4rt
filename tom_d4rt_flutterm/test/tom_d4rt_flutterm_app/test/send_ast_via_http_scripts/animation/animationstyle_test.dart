import 'package:flutter/material.dart';

/// Demonstrates AnimationStyle - configuration for implicit animations.
dynamic build(BuildContext context) {
  final style = AnimationStyle(
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 500),
  );
  final noAnimation = AnimationStyle.noAnimation;

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimationStyle Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _StyleRow('curve', 'Curves.easeInOut'),
            _StyleRow('duration', '500ms'),
            _StyleRow('reverseCurve', 'null (uses curve)'),
            _StyleRow('reverseDuration', 'null (uses duration)'),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StyleCard('Custom Style', Icons.tune, Colors.deepPurple),
          const SizedBox(width: 12),
          _StyleCard('noAnimation', Icons.block, Colors.grey),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Pass to widgets like ExpansionTile.expansionAnimationStyle', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _StyleRow extends StatelessWidget {
  final String prop; final String val;
  const _StyleRow(this.prop, this.val);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 100, child: Text(prop, style: const TextStyle(fontFamily: 'monospace', fontSize: 11))),
        Text(val, style: const TextStyle(fontSize: 11)),
      ],
    ),
  );
}

class _StyleCard extends StatelessWidget {
  final String label; final IconData icon; final Color color;
  const _StyleCard(this.label, this.icon, this.color);
  @override
  Widget build(BuildContext context) => Container(
    width: 100, padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Column(children: [Icon(icon, color: color), const SizedBox(height: 4), Text(label, style: TextStyle(fontSize: 10, color: color))]),
  );
}
