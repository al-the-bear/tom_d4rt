import 'package:flutter/material.dart';

/// Deep visual demo for CheckmarkableChipAttributes.
/// Shows chip attributes for checkmark display.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CheckmarkableChipAttributes')),
    body: _ChipDemo(),
  );
}

class _ChipDemo extends StatefulWidget {
  @override
  State<_ChipDemo> createState() => _ChipDemoState();
}

class _ChipDemoState extends State<_ChipDemo> {
  final _selected = <String>{'Flutter'};

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Checkmarkable Chips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('FilterChip and ChoiceChip support checkmarks'),
        const SizedBox(height: 24),
        const Text('FilterChip (with checkmark):', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['Flutter', 'Dart', 'Firebase', 'Cloud'].map((tag) => FilterChip(
            label: Text(tag),
            selected: _selected.contains(tag),
            showCheckmark: true,
            checkmarkColor: Colors.white,
            onSelected: (v) => setState(() => v ? _selected.add(tag) : _selected.remove(tag)),
          )).toList(),
        ),
        const SizedBox(height: 24),
        const Text('FilterChip (no checkmark):', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['A', 'B', 'C'].map((tag) => FilterChip(
            label: Text(tag),
            selected: _selected.contains(tag),
            showCheckmark: false,
            onSelected: (v) => setState(() => v ? _selected.add(tag) : _selected.remove(tag)),
          )).toList(),
        ),
        const SizedBox(height: 16),
        Text('Selected: ' + _selected.join(', ')),
      ],
    );
  }
}
