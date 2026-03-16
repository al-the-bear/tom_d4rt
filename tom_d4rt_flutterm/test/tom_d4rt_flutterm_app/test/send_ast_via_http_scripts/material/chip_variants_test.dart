import 'package:flutter/material.dart';

/// Deep visual demo for Chip variants.
/// Shows all chip types.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Chip Variants')),
    body: _ChipVariantsDemo(),
  );
}

class _ChipVariantsDemo extends StatefulWidget {
  @override
  State<_ChipVariantsDemo> createState() => _ChipVariantsDemoState();
}

class _ChipVariantsDemoState extends State<_ChipVariantsDemo> {
  int _choice = 0;
  final _filters = <int>{};

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Chip Types', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Chip (basic):', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(spacing: 8, children: [
          const Chip(label: Text('Basic')),
          Chip(avatar: const CircleAvatar(child: Text('U')), label: const Text('User')),
          Chip(label: const Text('Deletable'), onDeleted: () {}),
        ]),
        const SizedBox(height: 16),
        const Text('ActionChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(spacing: 8, children: [
          ActionChip(label: const Text('Action'), onPressed: () {}),
          ActionChip(avatar: const Icon(Icons.add), label: const Text('Add'), onPressed: () {}),
        ]),
        const SizedBox(height: 16),
        const Text('ChoiceChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(spacing: 8, children: [
          for (int i = 0; i < 3; i++)
            ChoiceChip(label: Text('Option ' + (i + 1).toString()), selected: _choice == i, onSelected: (_) => setState(() => _choice = i)),
        ]),
        const SizedBox(height: 16),
        const Text('FilterChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(spacing: 8, children: [
          for (int i = 0; i < 4; i++)
            FilterChip(label: Text('Filter ' + (i + 1).toString()), selected: _filters.contains(i), onSelected: (v) => setState(() => v ? _filters.add(i) : _filters.remove(i))),
        ]),
        const SizedBox(height: 16),
        const Text('InputChip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(spacing: 8, children: [
          InputChip(label: const Text('Input'), onDeleted: () {}),
          InputChip(avatar: const CircleAvatar(child: Text('J')), label: const Text('John'), onDeleted: () {}),
        ]),
      ],
    );
  }
}
