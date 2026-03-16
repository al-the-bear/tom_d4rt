import 'package:flutter/material.dart';

/// Deep visual demo for CustomPainter proxy pattern
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('CustomPainter Proxy')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Canvas Drawing Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 16),
    Expanded(child: Center(child: Container(width: 250, height: 250, decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: CustomPaint(painter: _CirclesPainter(), child: Center(child: Text('CustomPaint', style: TextStyle(fontWeight: FontWeight.bold))))))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('CustomPainter methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• paint(Canvas, Size) - draw content', style: TextStyle(fontSize: 11)),
        Text('• shouldRepaint(oldDelegate) → bool', style: TextStyle(fontSize: 11)),
        Text('• semanticsBuilder - accessibility', style: TextStyle(fontSize: 11)),
        Text('• hitTest(position) → bool', style: TextStyle(fontSize: 11)),
      ]))
  ])));
}

class _CirclesPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2;
    final colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue];
    for (int i = 0; i < 5; i++) {
      paint.color = colors[i];
      canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30.0 + i * 20, paint);
    }
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
