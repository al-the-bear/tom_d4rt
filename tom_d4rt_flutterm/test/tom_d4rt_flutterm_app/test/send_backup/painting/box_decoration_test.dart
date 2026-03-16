import 'package:flutter/material.dart';

/// Deep visual demo for BoxDecoration
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BoxDecoration Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Wrap(spacing: 16, runSpacing: 16, children: [Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.blue)), Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(16))), Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle)), Container(width: 100, height: 100, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple, Colors.pink]))), Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))])), Container(width: 100, height: 100, decoration: BoxDecoration(border: Border.all(width: 3, color: Colors.red), borderRadius: BorderRadius.circular(8)))])));
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
