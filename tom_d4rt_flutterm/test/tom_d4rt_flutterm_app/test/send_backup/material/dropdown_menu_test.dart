import 'package:flutter/material.dart';

/// Deep visual demo for DropdownMenu - Material 3 dropdown menu.
/// Shows searchable dropdown with menu entries.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DropdownMenu Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // Closed state
      Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            const Icon(Icons.color_lens, color: Colors.blue),
            const SizedBox(width: 12),
            const Text('Select Color'),
            const Spacer(),
            Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
          ],
        ),
      ),
      const SizedBox(height: 8),
      // Open state (menu)
      Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Column(
          children: [
            _ColorEntry('Red', Colors.red),
            _ColorEntry('Green', Colors.green),
            _ColorEntry('Blue', Colors.blue),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Material 3 searchable dropdown', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ColorEntry extends StatelessWidget {
  final String name;
  final Color color;
  const _ColorEntry(this.name, this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(width: 20, height: 20, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Text(name),
        ],
      ),
    );
  }
}
