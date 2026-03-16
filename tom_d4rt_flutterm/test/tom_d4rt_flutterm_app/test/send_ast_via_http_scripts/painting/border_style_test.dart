import 'package:flutter/material.dart';

/// Deep visual demo for BorderStyle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BorderStyle Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 150, height: 80, decoration: BoxDecoration(border: Border.all(width: 3, color: Colors.blue, style: BorderStyle.solid)), child: Center(child: Text('solid'))), SizedBox(height: 20), Container(width: 150, height: 80, decoration: BoxDecoration(border: Border.all(width: 3, color: Colors.transparent, style: BorderStyle.none)), color: Colors.grey.shade200, child: Center(child: Text('none')))])));
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
