// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for PositionedGestureDetails.
/// Shows position info common to gesture callbacks.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PositionedGestureDetails')),
    body: Center(child: _PositionDemo()),
  );
}

class _PositionDemo extends StatefulWidget {
  @override
  State<_PositionDemo> createState() => _PositionDemoState();
}

class _PositionDemoState extends State<_PositionDemo> {
  Offset _globalPos = Offset.zero;
  Offset _localPos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Tap anywhere in the box', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        GestureDetector(
          onTapDown: (d) => setState(() {
            _globalPos = d.globalPosition;
            _localPos = d.localPosition;
          }),
          child: Container(
            width: 280,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.cyan.shade50,
              border: Border.all(color: Colors.cyan, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                if (_localPos != Offset.zero)
                  Positioned(
                    left: _localPos.dx - 8,
                    top: _localPos.dy - 8,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                const Center(
                  child: Text('Tap here', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.public, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'globalPosition: (\${_globalPos.dx.toInt()}, \${_globalPos.dy.toInt()})',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.crop_free, size: 16, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    'localPosition: (\${_localPos.dx.toInt()}, \${_localPos.dy.toInt()})',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      'PositionDemoState(globalPos: $_globalPos)';
}
