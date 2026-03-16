import 'package:flutter/material.dart';

/// Deep visual demo for ButtonStyleButton.
/// Shows base class for styled buttons.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ButtonStyleButton')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('ButtonStyleButton Subclasses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Abstract base class for buttons with ButtonStyle', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        _ButtonSection('ElevatedButton', ElevatedButton(onPressed: () {}, child: const Text('Elevated')), Colors.blue.shade50),
        _ButtonSection('FilledButton', FilledButton(onPressed: () {}, child: const Text('Filled')), Colors.purple.shade50),
        _ButtonSection('FilledButton.tonal', FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')), Colors.teal.shade50),
        _ButtonSection('OutlinedButton', OutlinedButton(onPressed: () {}, child: const Text('Outlined')), Colors.orange.shade50),
        _ButtonSection('TextButton', TextButton(onPressed: () {}, child: const Text('Text')), Colors.green.shade50),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: const Text('All inherit from ButtonStyleButton and use ButtonStyle for customization', style: TextStyle(fontSize: 12)),
        ),
      ],
    ),
  );
}

class _ButtonSection extends StatelessWidget {
  final String name; final Widget button; final Color bg;
  const _ButtonSection(this.name, this.button, this.bg);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [SizedBox(width: 140, child: Text(name)), button]),
  );
}
