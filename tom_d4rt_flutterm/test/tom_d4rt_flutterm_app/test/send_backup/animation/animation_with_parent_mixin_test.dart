import 'package:flutter/material.dart';

/// Demonstrates AnimationWithParentMixin - creates derived animations from a parent.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimationWithParentMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // Parent animation at top
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(8)),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.animation, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Parent Animation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Icon(Icons.arrow_downward, color: Colors.cyan),
            const SizedBox(height: 8),
            // Derived animations
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DerivedBox('CurveTween', Colors.purple),
                const SizedBox(width: 8),
                _DerivedBox('Interval', Colors.orange),
                const SizedBox(width: 8),
                _DerivedBox('ReverseAnimation', Colors.red),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Transforms parent value to derived value', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DerivedBox extends StatelessWidget {
  final String label; final Color color;
  const _DerivedBox(this.label, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
    child: Text(label, style: TextStyle(fontSize: 9, color: color)),
  );
}
