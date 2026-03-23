// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for ScaleStartDetails and related classes.
/// Shows scale gesture callback data.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Scale Details')),
    body: Center(child: _ScaleDetailsDemo()),
  );
}

class _ScaleDetailsDemo extends StatefulWidget {
  @override
  State<_ScaleDetailsDemo> createState() => _ScaleDetailsDemoState();
}

class _ScaleDetailsDemoState extends State<_ScaleDetailsDemo> {
  double _scale = 1.0;
  double _rotation = 0.0;
  Offset _focalPoint = Offset.zero;
  int _pointers = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Pinch/zoom with two fingers',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onScaleStart: (d) => setState(() {
            _focalPoint = d.localFocalPoint;
            _pointers = d.pointerCount;
          }),
          onScaleUpdate: (d) => setState(() {
            _scale = d.scale;
            _rotation = d.rotation;
            _focalPoint = d.localFocalPoint;
            _pointers = d.pointerCount;
          }),
          onScaleEnd: (_) => setState(() => _pointers = 0),
          child: Container(
            width: 280,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              border: Border.all(color: Colors.pink, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: _scale.clamp(0.5, 2.0),
              child: Transform.rotate(
                angle: _rotation,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.zoom_out_map, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text('Scale: \${_scale.toStringAsFixed(2)}x'),
              Text('Rotation: \${(_rotation * 57.3).toStringAsFixed(1)}°'),
              Text(
                'Focal: (\${_focalPoint.dx.toInt()}, \${_focalPoint.dy.toInt()})',
              ),
              Text('Pointers: \$_pointers'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      'ScaleDetailsDemoState(focalPoint: $_focalPoint, pointers: $_pointers)';
}
