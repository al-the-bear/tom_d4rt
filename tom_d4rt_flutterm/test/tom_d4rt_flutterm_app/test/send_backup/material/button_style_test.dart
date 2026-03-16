import 'package:flutter/material.dart';

/// Deep visual demo for ButtonStyle.
/// Shows button customization options.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ButtonStyle')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Styled Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () {},
          child: const Text('Custom Rounded'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) return Colors.green.shade700;
              if (states.contains(WidgetState.hovered)) return Colors.green.shade300;
              return Colors.green;
            }),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: () {},
          child: const Text('State-Aware Colors'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.orange, width: 2),
            foregroundColor: Colors.orange,
          ),
          onPressed: () {},
          child: const Text('Custom Border'),
        ),
        const SizedBox(height: 24),
        const Text('ButtonStyle Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        _PropItem('backgroundColor', 'WidgetStateProperty<Color?>'),
        _PropItem('foregroundColor', 'WidgetStateProperty<Color?>'),
        _PropItem('overlayColor', 'WidgetStateProperty<Color?>'),
        _PropItem('elevation', 'WidgetStateProperty<double?>'),
        _PropItem('padding', 'WidgetStateProperty<EdgeInsets?>'),
        _PropItem('shape', 'WidgetStateProperty<OutlinedBorder?>'),
        _PropItem('side', 'WidgetStateProperty<BorderSide?>'),
      ],
    ),
  );
}

class _PropItem extends StatelessWidget {
  final String name, type;
  const _PropItem(this.name, this.type);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w500)), const Spacer(), Text(type, style: const TextStyle(fontSize: 11, color: Colors.grey))]),
  );
}
