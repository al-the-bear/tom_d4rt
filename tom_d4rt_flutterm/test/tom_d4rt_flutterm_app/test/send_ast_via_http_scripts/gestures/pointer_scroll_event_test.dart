import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// Deep visual demo for PointerScrollEvent.
/// Shows mouse wheel/trackpad scroll events.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerScrollEvent')),
    body: Center(child: _ScrollDemo()),
  );
}

class _ScrollDemo extends StatefulWidget {
  @override
  State<_ScrollDemo> createState() => _ScrollDemoState();
}

class _ScrollDemoState extends State<_ScrollDemo> {
  double _totalX = 0;
  double _totalY = 0;
  int _eventCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Scroll with mouse wheel or trackpad',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Listener(
          onPointerSignal: (e) {
            if (e is PointerScrollEvent) {
              setState(() {
                _totalX += (e).scrollDelta.dx;
                _totalY += (e).scrollDelta.dy;
                _eventCount++;
              });
            }
          },
          child: Container(
            width: 280,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              border: Border.all(color: Colors.teal, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.mouse, size: 40, color: Colors.teal),
                const SizedBox(height: 12),
                Text(
                  'Δx: \${_totalX.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Δy: \${_totalY.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Scroll events: \$_eventCount'),
        ElevatedButton(
          onPressed: () => setState(() {
            _totalX = 0;
            _totalY = 0;
            _eventCount = 0;
          }),
          child: const Text('Reset'),
        ),
      ],
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      'ScrollDemoState(totalX: $_totalX, totalY: $_totalY, eventCount: $_eventCount)';
}
