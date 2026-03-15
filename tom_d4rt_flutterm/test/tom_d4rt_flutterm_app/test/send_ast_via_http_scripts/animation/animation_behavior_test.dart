import 'package:flutter/material.dart';

/// Demonstrates AnimationBehavior enum - controls accessibility compliance.
/// .normal = plays animations, .preserve = respects "reduce motion" settings.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimationBehavior Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _BehaviorCard(
            behavior: AnimationBehavior.normal,
            icon: Icons.animation,
            description: 'Animations always play',
            color: Colors.blue,
          ),
          const SizedBox(width: 16),
          _BehaviorCard(
            behavior: AnimationBehavior.preserve,
            icon: Icons.accessibility_new,
            description: 'Respects reduce motion',
            color: Colors.green,
          ),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Column(
          children: [
            Text('Usage in AnimationController:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            SizedBox(height: 4),
            Text('AnimationController(\n  vsync: this,\n  behavior: AnimationBehavior.preserve,\n)',
                style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
          ],
        ),
      ),
    ],
  );
}

class _BehaviorCard extends StatelessWidget {
  final AnimationBehavior behavior;
  final IconData icon;
  final String description;
  final Color color;
  const _BehaviorCard({required this.behavior, required this.icon, required this.description, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130, padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(behavior.name, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
