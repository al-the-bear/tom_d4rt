import 'package:flutter/material.dart';

/// Deep visual demo for ChipAnimationStyle.
/// Shows chip transition animations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ChipAnimationStyle')),
    body: _AnimatedChipDemo(),
  );
}

class _AnimatedChipDemo extends StatefulWidget {
  @override
  State<_AnimatedChipDemo> createState() => _AnimatedChipDemoState();
}

class _AnimatedChipDemoState extends State<_AnimatedChipDemo> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Chip Animation Style', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Customize selection and enable/disable animations'),
        const SizedBox(height: 24),
        FilterChip(
          label: const Text('Animated Chip'),
          selected: _selected,
          onSelected: (v) => setState(() => _selected = v),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => _selected = !_selected),
          child: Text(_selected ? 'Deselect' : 'Select'),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ChipAnimationStyle properties:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• enableAnimation - Duration for enable'),
              Text('• selectAnimation - Duration for select'),
              Text('• avatarDrawerAnimation - Avatar reveal'),
              Text('• deleteDrawerAnimation - Delete icon'),
            ],
          ),
        ),
      ],
    );
  }
}
