import 'package:flutter/material.dart';

/// Deep visual demo for ClipPathLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ClipPathLayer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Path Clipping Layer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Center(child: ClipPath(clipper: _StarClipper(),
      child: Container(width: 200, height: 200, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple, Colors.blue, Colors.cyan])))))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('ClipPathLayer:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Clips children to arbitrary path', style: TextStyle(fontSize: 11)),
        Text('• More flexible than ClipRect/ClipOval', style: TextStyle(fontSize: 11)),
        Text('• Higher performance cost', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _StarClipper extends CustomClipper<Path> {
  @override Path getClip(Size size) {
    final path = Path();
    final cx = size.width / 2, cy = size.height / 2;
    final outer = size.width / 2, inner = size.width / 4;
    for (int i = 0; i < 5; i++) {
      final angle1 = (i * 72 - 90) * 3.14159 / 180;
      final angle2 = ((i * 72) + 36 - 90) * 3.14159 / 180;
      if (i == 0) path.moveTo(cx + outer * angle1.cos(), cy + outer * angle1.sin());
      else path.lineTo(cx + outer * angle1.cos(), cy + outer * angle1.sin());
      path.lineTo(cx + inner * angle2.cos(), cy + inner * angle2.sin());
    }
    path.close();
    return path;
  }
  @override bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

extension on double { double cos() => this >= 0 ? (this % 6.28319) : 0; double sin() => this >= 0 ? (this % 6.28319) : 0; }
