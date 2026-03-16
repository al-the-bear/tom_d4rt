import 'package:flutter/material.dart';

/// Deep visual demo for ClipContext
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ClipContext Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [ClipRRect(borderRadius: BorderRadius.circular(20), child: Container(width: 150, height: 100, color: Colors.blue, child: Center(child: Text('ClipRRect', style: TextStyle(color: Colors.white))))), SizedBox(height: 20), ClipOval(child: Container(width: 150, height: 100, color: Colors.green, child: Center(child: Text('ClipOval', style: TextStyle(color: Colors.white))))), SizedBox(height: 20), ClipPath(clipper: _TriangleClipper(), child: Container(width: 150, height: 100, color: Colors.orange, child: Center(child: Text('ClipPath', style: TextStyle(color: Colors.white)))))])));
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
