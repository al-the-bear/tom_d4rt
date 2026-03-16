import 'package:flutter/material.dart';

/// Deep visual demo for CustomPainter accessibility semantics
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('CustomPainter Semantics')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Accessible Custom Paint', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Semantics(label: 'Chart showing 3 data points',
      child: CustomPaint(painter: _ChartPainter(), child: Container()))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('SemanticsBuilderCallback:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Returns List<CustomPainterSemantics>', style: TextStyle(fontSize: 11)),
        Text('• Each defines rect + properties', style: TextStyle(fontSize: 11)),
        Text('• Enables screen reader for canvas', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _ChartPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final colors = [Colors.blue, Colors.orange, Colors.green];
    final values = [0.6, 0.8, 0.4];
    final barW = size.width / 5;
    for (int i = 0; i < 3; i++) {
      paint.color = colors[i];
      final h = size.height * values[i];
      canvas.drawRect(Rect.fromLTWH(barW * (i + 1), size.height - h, barW * 0.8, h), paint);
    }
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
