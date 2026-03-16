import 'package:flutter/material.dart';

/// Deep visual demo for Chip widget.
/// Shows basic chip usage patterns.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Chip')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Basic Chips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            const Chip(label: Text('Simple')),
            Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue.shade100, child: const Text('A')),
              label: const Text('With Avatar'),
            ),
            Chip(
              label: const Text('Deletable'),
              deleteIcon: const Icon(Icons.cancel, size: 18),
              onDeleted: () {},
            ),
            Chip(
              avatar: const Icon(Icons.tag, size: 16),
              label: const Text('flutter'),
              backgroundColor: Colors.blue.shade50,
            ),
            const Chip(
              avatar: CircleAvatar(backgroundImage: NetworkImage('https://via.placeholder.com/40')),
              label: Text('With Image'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Common Use Cases:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _UseCase('Tags', 'Label content categories'),
        _UseCase('Contacts', 'Show selected people'),
        _UseCase('Filters', 'Active filter indicators'),
        _UseCase('Input', 'Multi-value text fields'),
      ],
    ),
  );
}

class _UseCase extends StatelessWidget {
  final String title, desc;
  const _UseCase(this.title, this.desc);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [const Icon(Icons.check, size: 16, color: Colors.green), const SizedBox(width: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.w500)), const SizedBox(width: 8), Text(desc, style: const TextStyle(color: Colors.grey))]),
  );
}
