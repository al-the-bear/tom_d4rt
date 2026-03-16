import 'package:flutter/material.dart';

/// Deep visual demo for SerialTapDownDetails.
/// Shows info for each tap in a series.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SerialTapDownDetails')),
    body: Center(child: _SerialTapDemo()),
  );
}

class _SerialTapDemo extends StatefulWidget {
  @override
  State<_SerialTapDemo> createState() => _SerialTapDemoState();
}

class _SerialTapDemoState extends State<_SerialTapDemo> {
  int _tapCount = 0;
  String _lastKind = 'N/A';
  List<int> _history = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Tap repeatedly (triple-tap, etc.)', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => setState(() {
            _tapCount++;
            _history.add(_tapCount);
            if (_history.length > 5) _history.removeAt(0);
          }),
          onDoubleTap: () => setState(() => _lastKind = 'Double'),
          child: Container(
            width: 200, height: 120,
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber, width: 2),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('\$_tapCount', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber)),
                const Text('taps', style: TextStyle(color: Colors.amber)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              const Text('SerialTapDownDetails provides:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('• count - which tap in sequence', style: TextStyle(fontSize: 12)),
              const Text('• globalPosition - tap location', style: TextStyle(fontSize: 12)),
              const Text('• localPosition - in widget coords', style: TextStyle(fontSize: 12)),
              const Text('• kind - PointerDeviceKind', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text('Recent: \${_history.join(" → ")}'),
      ],
    );
  }
}
