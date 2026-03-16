import 'package:flutter/material.dart';

/// Deep visual demo for filled SearchBar variant.
/// Search bar with filled background style.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Filled SearchBar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(28)),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey, size: 20),
            const SizedBox(width: 12),
            Text('Search in app', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            const Spacer(),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade100),
              child: const Icon(Icons.person, size: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StyleChip('Outlined', false),
          const SizedBox(width: 8),
          _StyleChip('Filled', true),
        ],
      ),
    ],
  );
}

class _StyleChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _StyleChip(this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.transparent,
        border: Border.all(color: selected ? Colors.blue : Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.grey, fontSize: 10)),
    );
  }
}
