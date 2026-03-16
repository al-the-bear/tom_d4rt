import 'package:flutter/material.dart';

/// Deep visual demo for layout RenderObjects
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Layout RenderObjects')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layout Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _LayoutDemo('RenderFlex (Row)', Row(children: [_Box('A', Colors.red), _Box('B', Colors.green), _Box('C', Colors.blue)])),
      _LayoutDemo('RenderFlex (Column)', SizedBox(height: 100, child: Column(children: [_Box('1', Colors.orange), _Box('2', Colors.purple)]))),
      _LayoutDemo('RenderStack', SizedBox(height: 80, child: Stack(children: [Positioned(left: 0, child: _Box('X', Colors.red)), Positioned(left: 30, child: _Box('Y', Colors.green)), Positioned(left: 60, child: _Box('Z', Colors.blue))]))),
      _LayoutDemo('RenderWrap', Wrap(spacing: 4, runSpacing: 4, children: List.generate(8, (i) => _Box('$i', Colors.teal)))),
    ])),
  ])));
}

Widget _Box(String t, Color c) => Container(width: 40, height: 40, color: c, child: Center(child: Text(t, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))));

class _LayoutDemo extends StatelessWidget {
  final String label; final Widget child;
  const _LayoutDemo(this.label, this.child);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), SizedBox(height: 8), child]));
}
