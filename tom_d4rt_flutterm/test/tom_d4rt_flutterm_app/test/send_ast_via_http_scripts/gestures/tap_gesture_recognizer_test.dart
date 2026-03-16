import 'package:flutter/material.dart';

/// Deep visual demo for TapGestureRecognizer.
/// Shows tap detection and callbacks.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapGestureRecognizer')),
    body: Center(child: _TapDemo()),
  );
}

class _TapDemo extends StatefulWidget {
  @override
  State<_TapDemo> createState() => _TapDemoState();
}

class _TapDemoState extends State<_TapDemo> {
  String _state = 'Idle';
  int _tapCount = 0;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Tap the button below', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 24),
        GestureDetector(
          onTapDown: (_) => setState(() { _state = 'Down'; _color = Colors.blue.shade700; }),
          onTapUp: (_) => setState(() { _state = 'Up'; _color = Colors.green; }),
          onTapCancel: () => setState(() { _state = 'Cancelled'; _color = Colors.red; }),
          onTap: () => setState(() { _tapCount++; _state = 'Tapped!'; }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 160, height: 80,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: _color.withAlpha(100), blurRadius: 8)],
            ),
            alignment: Alignment.center,
            child: Text(_state, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
        ),
        const SizedBox(height: 24),
        Text('Taps: \$_tapCount', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          width: 280,
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('• onTapDown - finger touches screen'),
              Text('• onTapUp - finger lifts (tap complete)'),
              Text('• onTap - simple tap confirmed'),
              Text('• onTapCancel - tap rejected'),
            ],
          ),
        ),
      ],
    );
  }
}
