import 'package:flutter/material.dart';

/// Deep visual demo for RawChip attributes.
/// Shows low-level chip customization.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('RawChip Attributes')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('RawChip Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Base chip with all customization options'),
        const SizedBox(height: 24),
        RawChip(
          avatar: const CircleAvatar(child: Text('A')),
          label: const Text('With Avatar'),
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        RawChip(
          label: const Text('With Delete'),
          deleteIcon: const Icon(Icons.close, size: 18),
          onDeleted: () {},
        ),
        const SizedBox(height: 12),
        RawChip(
          avatar: const Icon(Icons.star, size: 18),
          label: const Text('Selected'),
          selected: true,
          showCheckmark: true,
          onSelected: (v) {},
        ),
        const SizedBox(height: 12),
        RawChip(
          label: const Text('Custom Colors'),
          backgroundColor: Colors.amber.shade100,
          selectedColor: Colors.amber.shade300,
          onPressed: () {},
        ),
        const SizedBox(height: 24),
        const Text('Attributes:', style: TextStyle(fontWeight: FontWeight.bold)),
        _Attr('avatar', 'Leading widget'),
        _Attr('label', 'Main content'),
        _Attr('labelStyle', 'Text style'),
        _Attr('deleteIcon', 'Delete button'),
        _Attr('backgroundColor', 'Default color'),
        _Attr('selectedColor', 'Selected state color'),
      ],
    ),
  );
}

class _Attr extends StatelessWidget {
  final String name, desc;
  const _Attr(this.name, this.desc);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w500)), const SizedBox(width: 8), Text(desc, style: const TextStyle(color: Colors.grey))]),
  );
}
