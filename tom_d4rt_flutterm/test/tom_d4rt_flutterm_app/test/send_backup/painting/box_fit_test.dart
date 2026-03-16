import 'package:flutter/material.dart';

/// Deep visual demo for BoxFit
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BoxFit Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(8), child: Wrap(spacing: 8, runSpacing: 8, children: [for (final fit in [BoxFit.fill, BoxFit.contain, BoxFit.cover, BoxFit.fitWidth, BoxFit.fitHeight, BoxFit.none, BoxFit.scaleDown]) Column(children: [Container(width: 100, height: 80, color: Colors.grey.shade200, child: FittedBox(fit: fit, child: Container(width: 60, height: 40, color: Colors.blue, child: Center(child: Text('60x40', style: TextStyle(color: Colors.white, fontSize: 10)))))), Text(fit.toString().split('.').last, style: TextStyle(fontSize: 10))])])));
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
