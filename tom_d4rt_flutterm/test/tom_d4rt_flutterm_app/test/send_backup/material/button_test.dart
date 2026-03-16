import 'package:flutter/material.dart';

/// Deep visual demo for Button.
/// Shows various button types.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Buttons')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Button Types', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _Section('Elevated Button', ElevatedButton(onPressed: () {}, child: const Text('Elevated'))),
        _Section('Filled Button', FilledButton(onPressed: () {}, child: const Text('Filled'))),
        _Section('Filled Tonal', FilledButton.tonal(onPressed: () {}, child: const Text('Tonal'))),
        _Section('Outlined Button', OutlinedButton(onPressed: () {}, child: const Text('Outlined'))),
        _Section('Text Button', TextButton(onPressed: () {}, child: const Text('Text'))),
        _Section('Icon Button', IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))),
        const SizedBox(height: 16),
        const Text('With Icons', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send), label: const Text('Send')),
        const SizedBox(height: 8),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: const Text('Download')),
      ],
    ),
  );
}

class _Section extends StatelessWidget {
  final String label; final Widget button;
  const _Section(this.label, this.button);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(children: [SizedBox(width: 140, child: Text(label)), button]),
  );
}
