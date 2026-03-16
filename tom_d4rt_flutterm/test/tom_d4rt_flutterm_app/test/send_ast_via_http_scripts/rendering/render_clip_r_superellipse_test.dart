import 'package:flutter/material.dart';

/// Deep visual demo for RenderClipRSuperellipse (squircle clips)
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Superellipse Clip')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Squircle Clipping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Row(children: [
      Expanded(child: _ClipDemo('Rounded Rect', ClipRRect(borderRadius: BorderRadius.circular(24), child: Container(color: Colors.blue, child: Center(child: Text('RRect', style: TextStyle(color: Colors.white))))))),
      SizedBox(width: 8),
      Expanded(child: _ClipDemo('Superellipse', ClipPath(clipper: _SquircleClipper(), child: Container(color: Colors.purple, child: Center(child: Text('Squircle', style: TextStyle(color: Colors.white))))))),
    ])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Superellipse creates smooth iOS-style squircle corners', style: TextStyle(fontSize: 11))),
  ])));
}

class _ClipDemo extends StatelessWidget {
  final String name; final Widget child;
  const _ClipDemo(this.name, this.child);
  @override Widget build(BuildContext context) => Column(children: [
    Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    SizedBox(height: 8),
    Expanded(child: child),
  ]);
}

class _SquircleClipper extends CustomClipper<Path> {
  @override Path getClip(Size size) {
    return Path()..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(size.width * 0.25)));
  }
  @override bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
