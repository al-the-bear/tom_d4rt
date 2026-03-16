import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Deep visual demo for PictureLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PictureLayer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Picture Recording', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomPaint(painter: _PicturePainter())),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('PictureLayer contains recorded drawing commands', style: TextStyle(fontSize: 11))),
  ])));
}

class _PicturePainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50, paint);
    paint.color = Colors.red;
    canvas.drawRect(Rect.fromLTWH(20, 20, 80, 60), paint);
    paint.color = Colors.green;
    paint.strokeWidth = 4;
    paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
  }
  @override bool shouldRepaint(covariant CustomPainter old) => false;
}
