import 'package:flutter/material.dart';

/// Deep visual demo for TapDragUpdateDetails.
/// Shows continuous drag updates in tap-drag.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapDragUpdateDetails')),
    body: Center(child: _UpdateDemo()),
  );
}

class _UpdateDemo extends StatefulWidget {
  @override
  State<_UpdateDemo> createState() => _UpdateDemoState();
}

class _UpdateDemoState extends State<_UpdateDemo> {
  Offset _delta = Offset.zero;
  Offset _total = Offset.zero;
  int _updateCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Drag to see update details', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        GestureDetector(
          onPanUpdate: (d) => setState(() {
            _delta = d.delta;
            _total += d.delta;
            _updateCount++;
          }),
          onPanEnd: (_) => setState(() => _delta = Offset.zero),
          child: Container(
            width: 280, height: 180,
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              border: Border.all(color: Colors.teal, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.open_with, size: 40, color: Colors.teal),
                const SizedBox(height: 8),
                Text('Delta: (\${_delta.dx.toStringAsFixed(1)}, \${_delta.dy.toStringAsFixed(1)})',
                  style: const TextStyle(fontSize: 12)),
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
              Text('Updates received: \$_updateCount'),
              Text('Total delta: (\${_total.dx.toInt()}, \${_total.dy.toInt()})'),
              const SizedBox(height: 8),
              const Text('TapDragUpdateDetails provides:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('delta, globalPosition, localPosition', style: TextStyle(fontSize: 11)),
              const Text('offsetFromOrigin, consecutiveTapCount', style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
        TextButton(onPressed: () => setState(() { _total = Offset.zero; _updateCount = 0; }), child: const Text('Reset')),
      ],
    );
  }
}
