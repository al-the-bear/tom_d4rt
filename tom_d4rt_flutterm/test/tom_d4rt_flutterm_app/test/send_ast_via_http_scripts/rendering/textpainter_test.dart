import 'package:flutter/material.dart';

/// Deep visual demo for TextPainter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextPainter')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TextPainter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        CustomPaint(painter: _TextDemoPainter(), size: Size(200, 60)),
        SizedBox(height: 16),
        _Method('layout', 'Calculate text layout'),
        _Method('paint', 'Paint text to canvas'),
        _Method('getPositionForOffset', 'Hit test'),
        _Method('getBoxesForSelection', 'Selection rects'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Low-level text rendering API', style: TextStyle(fontSize: 11))),
  ])));
}

class _TextDemoPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    final painter = TextPainter(text: TextSpan(text: 'Hello World', style: TextStyle(fontSize: 24, color: Colors.purple)), textDirection: TextDirection.ltr);
    painter.layout();
    painter.paint(canvas, Offset.zero);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
