import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// Deep visual demo for PointerScaleEvent.
/// Shows trackpad pinch-to-zoom gesture events.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerScaleEvent')),
    body: Center(child: _ScaleDemo()),
  );
}

class _ScaleDemo extends StatefulWidget {
  @override
  State<_ScaleDemo> createState() => _ScaleDemoState();
}

class _ScaleDemoState extends State<_ScaleDemo> {
  double _scale = 1.0;
  int _eventCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Use trackpad pinch gesture',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Listener(
          onPointerSignal: (e) {
            // Note: Scale events are a type of pointer signal
            if (e is PointerPanZoomUpdateEvent) {
              final ev = e as PointerPanZoomUpdateEvent;
              setState(() {
                _scale = (_scale * ev.scale).clamp(0.3, 3.0);
                _eventCount++;
              });
            }
          },
          child: Container(
            width: 280,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: _scale,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  '\${(_scale * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Scale: \${_scale.toStringAsFixed(2)}x'),
        Text('Events: \$_eventCount'),
        TextButton(
          onPressed: () => setState(() => _scale = 1.0),
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
