import 'package:flutter/material.dart';

/// Deep visual demo for CustomClipper proxy pattern
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('CustomClipper Proxy')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('CustomClipper<Path> Proxy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 16),
    Expanded(child: Center(child: ClipPath(clipper: _WaveClipper(), child: Container(width: 200, height: 200, color: Colors.blue, child: Center(child: Text('Clipped!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))))))),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('CustomClipper<T> methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• getClip(Size) → T', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
        Text('• shouldReclip(covariant) → bool', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
        Text('• getApproximateClipRect(Size) → Rect', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
      ]))
  ])));
}

class _WaveClipper extends CustomClipper<Path> {
  @override Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height - 30);
    path.quadraticBezierTo(size.width * 3 / 4, size.height - 60, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
