import 'package:flutter/material.dart';

/// Deep visual demo for Canvas drawing
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Canvas')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Canvas Drawing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomPaint(painter: _DemoPainter(), child: Container())),
    SizedBox(height: 16),
    Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
      _MethodChip('drawLine'),
      _MethodChip('drawRect'),
      _MethodChip('drawCircle'),
      _MethodChip('drawPath'),
      _MethodChip('drawArc'),
      _MethodChip('drawImage'),
    ]),
  ])));
}

class _DemoPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 3;
    paint.color = Colors.red;
    canvas.drawLine(Offset(20, 20), Offset(size.width - 20, 20), paint);
    paint.color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(20, 40, 80, 60), paint);
    paint.color = Colors.green;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 40, paint..style = PaintingStyle.fill);
    paint.color = Colors.purple;
    canvas.drawOval(Rect.fromLTWH(size.width - 120, 40, 100, 60), paint..style = PaintingStyle.stroke);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MethodChip extends StatelessWidget {
  final String name;
  const _MethodChip(this.name);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)), child: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)));
}
