import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for VelocityTracker.
/// Shows tracking of pointer velocity over time.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('VelocityTracker')),
    body: Center(child: _TrackerDemo()),
  );
}

class _TrackerDemo extends StatefulWidget {
  @override
  State<_TrackerDemo> createState() => _TrackerDemoState();
}

class _TrackerDemoState extends State<_TrackerDemo> {
  final _tracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  Offset _velocity = Offset.zero;
  int _sampleCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Drag to track velocity samples', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Listener(
          onPointerDown: (e) {
            _tracker.addPosition(e.timeStamp, e.localPosition);
            setState(() => _sampleCount = 1);
          },
          onPointerMove: (e) {
            _tracker.addPosition(e.timeStamp, e.localPosition);
            final estimate = _tracker.getVelocityEstimate();
            setState(() {
              _sampleCount++;
              if (estimate != null) {
                _velocity = estimate.pixelsPerSecond;
              }
            });
          },
          onPointerUp: (e) {
            final vel = _tracker.getVelocity();
            setState(() => _velocity = vel.pixelsPerSecond);
          },
          child: Container(
            width: 280, height: 180,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              border: Border.all(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.speed, size: 40, color: Colors.green),
                const SizedBox(height: 8),
                Text('Samples: \$_sampleCount'),
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
              Text('Velocity: (\${_velocity.dx.toStringAsFixed(0)}, \${_velocity.dy.toStringAsFixed(0)}) px/s'),
              const SizedBox(height: 8),
              const Text('VelocityTracker API:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('• addPosition(time, position)', style: TextStyle(fontSize: 11)),
              const Text('• getVelocity() → Velocity', style: TextStyle(fontSize: 11)),
              const Text('• getVelocityEstimate() → VelocityEstimate?', style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => 'TrackerDemoState(velocity: $_velocity, sampleCount: $_sampleCount)';
}
