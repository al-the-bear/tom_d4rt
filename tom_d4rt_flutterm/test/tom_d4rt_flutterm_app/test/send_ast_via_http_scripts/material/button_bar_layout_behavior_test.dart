import 'package:flutter/material.dart';

/// Deep visual demo for ButtonBarLayoutBehavior.
/// Shows button bar layout modes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ButtonBarLayoutBehavior')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Layout Behaviors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _BehaviorDemo('constrained', ButtonBarLayoutBehavior.constrained),
        const SizedBox(height: 16),
        _BehaviorDemo('padded', ButtonBarLayoutBehavior.padded),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enum Values:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• constrained - buttons share space'),
              Text('• padded - buttons maintain padding'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _BehaviorDemo extends StatelessWidget {
  final String name;
  final ButtonBarLayoutBehavior behavior;
  const _BehaviorDemo(this.name, this.behavior);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          color: Colors.grey.shade200,
          child: ButtonBarTheme(
            data: ButtonBarThemeData(layoutBehavior: behavior),
            child: ButtonBar(
              children: [
                TextButton(onPressed: () {}, child: const Text('Cancel')),
                ElevatedButton(onPressed: () {}, child: const Text('OK')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
