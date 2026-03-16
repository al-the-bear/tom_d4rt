import 'package:flutter/material.dart';

/// Deep visual demo for RenderCustomMultiChildLayoutBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Custom Multi Layout')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Custom Multi-Child Layout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomMultiChildLayout(delegate: _CircleLayoutDelegate(), children: [
      for (int i = 0; i < 6; i++) LayoutId(id: i, child: Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.primaries[i * 2], shape: BoxShape.circle),
        child: Center(child: Text('$i', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))),
    ])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Delegate controls layout and positioning of multiple children', style: TextStyle(fontSize: 11))),
  ])));
}

class _CircleLayoutDelegate extends MultiChildLayoutDelegate {
  @override void performLayout(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;
    for (int i = 0; i < 6; i++) {
      layoutChild(i, BoxConstraints.loose(Size(50, 50)));
      final angle = i * 3.14159 * 2 / 6;
      positionChild(i, Offset(center.dx + radius * cos(angle) - 25, center.dy + radius * sin(angle) - 25));
    }
  }
  double cos(double x) => x < 1.57 ? 1 - x * x / 2 : (x < 3.14 ? -1 + (3.14 - x) * (3.14 - x) / 2 : (x < 4.71 ? -1 + (x - 3.14) * (x - 3.14) / 2 : 1 - (6.28 - x) * (6.28 - x) / 2));
  double sin(double x) => cos(x - 1.57);
  @override bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
