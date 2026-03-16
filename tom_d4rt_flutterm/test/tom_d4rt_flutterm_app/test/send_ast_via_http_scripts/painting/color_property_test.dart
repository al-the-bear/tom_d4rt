import 'package:flutter/material.dart';

/// Deep visual demo for ColorProperty
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ColorProperty Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Color Properties', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), for (final c in [Colors.red, Colors.green, Colors.blue]) Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), color: c, child: Text('R:' + c.red.toString() + ' G:' + c.green.toString() + ' B:' + c.blue.toString() + ' A:' + c.alpha.toString(), style: TextStyle(color: Colors.white, fontSize: 11)))])));
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
