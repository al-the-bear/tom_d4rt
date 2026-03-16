import 'package:flutter/material.dart';

/// Deep visual demo for MaterialButton types.
/// Shows all Material button variants.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Button Types')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Material 3 Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Row('ElevatedButton', ElevatedButton(onPressed: () {}, child: const Text('Elevated'))),
        _Row('FilledButton', FilledButton(onPressed: () {}, child: const Text('Filled'))),
        _Row('FilledButton.tonal', FilledButton.tonal(onPressed: () {}, child: const Text('Tonal'))),
        _Row('OutlinedButton', OutlinedButton(onPressed: () {}, child: const Text('Outlined'))),
        _Row('TextButton', TextButton(onPressed: () {}, child: const Text('Text'))),
        const Divider(height: 32),
        const Text('Icon Variants', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _Row('ElevatedButton.icon', ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Add'))),
        _Row('FilledButton.icon', FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.save), label: const Text('Save'))),
        _Row('OutlinedButton.icon', OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit), label: const Text('Edit'))),
        const Divider(height: 32),
        const Text('FAB & IconButton', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _Row('FloatingActionButton', FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.add))),
        _Row('IconButton', IconButton(onPressed: () {}, icon: const Icon(Icons.settings))),
        _Row('IconButton.filled', IconButton.filled(onPressed: () {}, icon: const Icon(Icons.star))),
      ],
    ),
  );
}

class _Row extends StatelessWidget {
  final String label; final Widget button;
  const _Row(this.label, this.button);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(children: [SizedBox(width: 150, child: Text(label, style: const TextStyle(fontSize: 12))), button]),
  );
}
