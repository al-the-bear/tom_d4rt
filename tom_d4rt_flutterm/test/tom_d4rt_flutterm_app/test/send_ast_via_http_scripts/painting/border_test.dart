import 'package:flutter/material.dart';

/// Deep visual demo for Border
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Border Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [Container(width: 150, height: 80, decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.blue)), child: Center(child: Text('All sides'))), SizedBox(height: 16), Container(width: 150, height: 80, decoration: BoxDecoration(border: Border(top: BorderSide(width: 3, color: Colors.red), bottom: BorderSide(width: 3, color: Colors.green))), child: Center(child: Text('Top/Bottom'))), SizedBox(height: 16), Container(width: 150, height: 80, decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 2, color: Colors.purple))), child: Center(child: Text('Symmetric H'))), SizedBox(height: 16), Container(width: 150, height: 80, decoration: BoxDecoration(border: Border(left: BorderSide(width: 5, color: Colors.orange))), child: Center(child: Text('Left only')))])));
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
