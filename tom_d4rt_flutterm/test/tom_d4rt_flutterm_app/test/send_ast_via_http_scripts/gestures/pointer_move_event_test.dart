import 'package:flutter/material.dart';

/// Deep visual demo for PointerMoveEvent.
/// Shows movement tracking while pointer is down.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerMoveEvent')),
    body: Center(child: _MoveTracker()),
  );
}

class _MoveTracker extends StatefulWidget {
  @override
  State<_MoveTracker> createState() => _MoveTrackerState();
}

class _MoveTrackerState extends State<_MoveTracker> {
  final List<Offset> _points = [];
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Press and drag to draw', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Listener(
          onPointerDown: (e) => setState(() {
            _isDown = true;
            _points.clear();
            _points.add(e.localPosition);
          }),
          onPointerMove: (e) => setState(() => _points.add(e.localPosition)),
          onPointerUp: (_) => setState(() => _isDown = false),
          child: Container(
            width: 300, height: 200,
            decoration: BoxDecoration(
              color: _isDown ? Colors.green.shade50 : Colors.grey.shade100,
              border: Border.all(color: _isDown ? Colors.green : Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomPaint(painter: _PathPainter(_points)),
          ),
        ),
        const SizedBox(height: 16),
        Text('Points captured: \${_points.length}', style: const TextStyle(fontSize: 14)),
        ElevatedButton(onPressed: () => setState(() => _points.clear()), child: const Text('Clear')),
      ],
    );
  }
}

class _PathPainter extends CustomPainter {
  final List<Offset> points;
  _PathPainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue..strokeWidth = 3..strokeCap = StrokeCap.round;
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }
  @override
  bool shouldRepaint(covariant _PathPainter old) => true;
}
