import 'package:flutter/material.dart';

/// Deep visual demo for BoxShape
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BoxShape Demo')), body: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Column(children: [Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.rectangle)), SizedBox(height: 8), Text('rectangle')]), SizedBox(width: 30), Column(children: [Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)), SizedBox(height: 8), Text('circle')])])));
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
