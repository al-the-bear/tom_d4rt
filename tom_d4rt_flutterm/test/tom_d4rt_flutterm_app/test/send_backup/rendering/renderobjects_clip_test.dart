import 'package:flutter/material.dart';

/// Deep visual demo for clip RenderObjects
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Clip RenderObjects')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Clipping Variants', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _ClipDemo('ClipRect', ClipRect(child: _OverflowBox())),
      _ClipDemo('ClipRRect', ClipRRect(borderRadius: BorderRadius.circular(20), child: _OverflowBox())),
      _ClipDemo('ClipOval', ClipOval(child: _OverflowBox())),
      _ClipDemo('ClipPath', ClipPath(clipper: _TriangleClipper(), child: _OverflowBox())),
    ])),
  ])));
}

Widget _OverflowBox() => Container(width: 150, height: 100, color: Colors.purple.shade100, child: GridView.count(crossAxisCount: 3, children: List.generate(12, (i) => Container(margin: EdgeInsets.all(2), color: Colors.purple.withOpacity(0.3 + (i % 3) * 0.2)))));

class _ClipDemo extends StatelessWidget {
  final String name; final Widget child;
  const _ClipDemo(this.name, this.child);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [SizedBox(width: 80, child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))), Expanded(child: Center(child: child))]));
}

class _TriangleClipper extends CustomClipper<Path> {
  @override Path getClip(Size size) => Path()..moveTo(size.width / 2, 0)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
  @override bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
