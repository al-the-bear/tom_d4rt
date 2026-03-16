import 'package:flutter/material.dart';

/// Deep visual demo for Material text selection handles.
/// Shows different handle types used in text selection.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Selection Handle Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _HandleDemo('Left', true, false),
          const SizedBox(width: 24),
          _HandleDemo('Right', false, true),
          const SizedBox(width: 24),
          _HandleDemo('Collapsed', false, false),
        ],
      ),
      const SizedBox(height: 12),
      const Text('TextSelectionHandleType variants', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _HandleDemo extends StatelessWidget {
  final String label;
  final bool pointsLeft;
  final bool pointsRight;
  const _HandleDemo(this.label, this.pointsLeft, this.pointsRight);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 2, height: 20, color: Colors.blue),
        CustomPaint(
          size: const Size(20, 20),
          painter: _HandlePainter(pointsLeft, pointsRight),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class _HandlePainter extends CustomPainter {
  final bool left;
  final bool right;
  _HandlePainter(this.left, this.right);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    if (!left && !right) {
      canvas.drawCircle(Offset(size.width / 2, size.height / 2), 8, paint);
    } else {
      final path = Path();
      if (left) {
        path.moveTo(size.width, 0);
        path.lineTo(0, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width / 2, size.height);
        path.arcToPoint(Offset(size.width / 2, 0), radius: const Radius.circular(8));
      } else {
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width / 2, size.height);
        path.arcToPoint(Offset(size.width / 2, 0), radius: const Radius.circular(8), clockwise: false);
      }
      canvas.drawPath(path, paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
