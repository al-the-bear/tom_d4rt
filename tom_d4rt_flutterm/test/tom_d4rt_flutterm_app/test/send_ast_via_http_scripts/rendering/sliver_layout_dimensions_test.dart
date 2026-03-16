import 'package:flutter/material.dart';

/// Deep visual demo for SliverLayoutDimensions
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Layout Dimensions')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverLayoutDimensions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _DimensionVisual(),
        SizedBox(height: 16),
        _Field('scrollOffset', 'Scroll position'),
        _Field('precedingScrollExtent', 'Space before viewport'),
        _Field('viewportMainAxisExtent', 'Viewport height'),
        _Field('crossAxisExtent', 'Viewport width'),
      ]))),
  ])));
}

class _DimensionVisual extends StatelessWidget {
  @override Widget build(BuildContext context) => Container(height: 100, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.cyan, width: 2), borderRadius: BorderRadius.circular(8)),
    child: Stack(children: [
      Positioned(left: 4, top: 40, child: Icon(Icons.arrow_back, size: 16, color: Colors.cyan)),
      Positioned(right: 4, top: 40, child: Icon(Icons.arrow_forward, size: 16, color: Colors.cyan)),
      Positioned(left: 0, right: 0, top: 45, child: Center(child: Text('crossAxisExtent', style: TextStyle(fontSize: 9, color: Colors.cyan)))),
      Positioned(top: 4, left: 70, child: Icon(Icons.arrow_upward, size: 16, color: Colors.cyan)),
      Positioned(bottom: 4, left: 70, child: Icon(Icons.arrow_downward, size: 16, color: Colors.cyan)),
      Positioned(left: 90, top: 0, bottom: 0, child: Center(child: RotatedBox(quarterTurns: 3, child: Text('mainAxisExtent', style: TextStyle(fontSize: 9, color: Colors.cyan))))),
    ]));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
