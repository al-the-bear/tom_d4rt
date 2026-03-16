import 'package:flutter/material.dart';

/// Deep visual demo for BoxPainter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BoxPainter Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CustomPaint(size: Size(200, 150), painter: _DemoBoxPainter()), SizedBox(height: 20), Text('BoxPainter paints Decoration', style: TextStyle(color: Colors.grey))])));
}

class _DemoBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(10, 10, size.width - 20, size.height - 20), Radius.circular(12)), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
