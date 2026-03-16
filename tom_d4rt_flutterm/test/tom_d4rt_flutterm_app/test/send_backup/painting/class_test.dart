import 'package:flutter/material.dart';

/// Deep visual demo for PaintingClasses
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Painting Classes Demo')), body: ListView(padding: EdgeInsets.all(16), children: [ListTile(leading: Icon(Icons.brush, color: Colors.blue), title: Text('Color'), subtitle: Text('ARGB color representation')), ListTile(leading: Icon(Icons.gradient, color: Colors.purple), title: Text('Gradient'), subtitle: Text('Linear, Radial, Sweep gradients')), ListTile(leading: Icon(Icons.border_all, color: Colors.orange), title: Text('Border'), subtitle: Text('Box borders and decorations')), ListTile(leading: Icon(Icons.image, color: Colors.green), title: Text('ImageProvider'), subtitle: Text('Asset, Network, Memory images')), ListTile(leading: Icon(Icons.text_fields, color: Colors.red), title: Text('TextPainter'), subtitle: Text('Text layout and painting'))]));
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
