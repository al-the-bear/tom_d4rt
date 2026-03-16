import 'package:flutter/material.dart';

/// Deep visual demo for RenderCustomPaint
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('CustomPaint')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Custom Painting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomPaint(painter: _ShapesPainter(), foregroundPainter: _TextPainter(),
      child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('CustomPaint layers:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• painter: Behind child', style: TextStyle(fontSize: 11)),
        Text('• child: Widget layer', style: TextStyle(fontSize: 11)),
        Text('• foregroundPainter: Above child', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _ShapesPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = Colors.blue.shade200;
    canvas.drawCircle(Offset(80, 80), 60, paint);
    paint.color = Colors.orange.shade200;
    canvas.drawRect(Rect.fromLTWH(size.width - 140, 40, 100, 100), paint);
    paint.color = Colors.green.shade200;
    canvas.drawOval(Rect.fromLTWH(40, size.height - 120, 120, 80), paint);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TextPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {}
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
