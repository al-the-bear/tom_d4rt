import 'package:flutter/material.dart';

/// Deep visual demo for Slider semantics/accessibility.
/// Screen reader and accessibility support.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Slider Semantics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.accessibility_new, color: Colors.purple),
                SizedBox(width: 8),
                Text('Semantics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            _SemanticProp('semanticFormatterCallback', '(value) => "\${value.round()}%"'),
            const SizedBox(height: 8),
            _SemanticProp('label', 'Volume: 75%'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: const Column(
          children: [
            Text('Screen Reader:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('"Slider, Volume, 75 percent"', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    ],
  );
}

class _SemanticProp extends StatelessWidget {
  final String name;
  final String value;
  const _SemanticProp(this.name, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 9, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
