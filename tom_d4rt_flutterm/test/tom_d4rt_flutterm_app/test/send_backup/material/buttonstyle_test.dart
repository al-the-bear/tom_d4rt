import 'package:flutter/material.dart';

/// Deep visual demo for ButtonStyle.
/// Shows comprehensive button style options.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ButtonStyle')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('WidgetStateProperty Examples', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _StateDemo('Hover', Colors.blue.shade100, Colors.blue),
        _StateDemo('Pressed', Colors.green.shade100, Colors.green),
        _StateDemo('Disabled', Colors.grey.shade100, Colors.grey),
        _StateDemo('Focused', Colors.orange.shade100, Colors.orange),
        const SizedBox(height: 24),
        const Text('Interactive Demo:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) return Colors.grey.shade300;
              if (states.contains(WidgetState.pressed)) return Colors.green.shade700;
              if (states.contains(WidgetState.hovered)) return Colors.green.shade300;
              return Colors.green;
            }),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            elevation: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) return 0;
              if (states.contains(WidgetState.hovered)) return 8;
              return 4;
            }),
          ),
          onPressed: () {},
          child: const Padding(padding: EdgeInsets.all(16), child: Text('State-Aware Button')),
        ),
      ],
    ),
  );
}

class _StateDemo extends StatelessWidget {
  final String state; final Color bg; final Color color;
  const _StateDemo(this.state, this.bg, this.color);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.circle, color: color, size: 16), const SizedBox(width: 8), Text('WidgetState.' + state.toLowerCase())]),
  );
}
