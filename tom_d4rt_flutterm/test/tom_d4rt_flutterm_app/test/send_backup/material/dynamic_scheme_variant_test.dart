import 'package:flutter/material.dart';

/// Deep visual demo for DynamicSchemeVariant - Material 3 color scheme variants.
/// Shows different algorithmic approaches to generate color schemes.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DynamicSchemeVariant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          _VariantChip('tonalSpot', Colors.blue),
          _VariantChip('fidelity', Colors.green),
          _VariantChip('monochrome', Colors.grey),
          _VariantChip('neutral', Colors.blueGrey),
          _VariantChip('vibrant', Colors.purple),
          _VariantChip('expressive', Colors.orange),
          _VariantChip('content', Colors.teal),
          _VariantChip('rainbow', Colors.pink),
          _VariantChip('fruitSalad', Colors.red),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Text('Algorithms for color scheme generation', style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _VariantChip extends StatelessWidget {
  final String name;
  final Color color;
  const _VariantChip(this.name, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
