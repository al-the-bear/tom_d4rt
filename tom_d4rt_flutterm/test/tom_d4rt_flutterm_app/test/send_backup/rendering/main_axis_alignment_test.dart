import 'package:flutter/material.dart';

/// Deep visual demo for MainAxisAlignment enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MainAxisAlignment')), body: Padding(padding: EdgeInsets.all(12), child: Column(children: [
    Text('Main Axis Alignments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 12),
    Expanded(child: ListView(children: [
      _AlignDemo(MainAxisAlignment.start, 'start'),
      _AlignDemo(MainAxisAlignment.end, 'end'),
      _AlignDemo(MainAxisAlignment.center, 'center'),
      _AlignDemo(MainAxisAlignment.spaceBetween, 'spaceBetween'),
      _AlignDemo(MainAxisAlignment.spaceAround, 'spaceAround'),
      _AlignDemo(MainAxisAlignment.spaceEvenly, 'spaceEvenly'),
    ])),
  ])));
}

class _AlignDemo extends StatelessWidget {
  final MainAxisAlignment alignment; final String name;
  const _AlignDemo(this.alignment, this.name);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      SizedBox(height: 4),
      Container(height: 40, decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
        child: Row(mainAxisAlignment: alignment, children: [_Box(Colors.blue), _Box(Colors.orange), _Box(Colors.green)])),
    ]));
}

class _Box extends StatelessWidget {
  final Color color;
  const _Box(this.color);
  @override Widget build(BuildContext context) => Container(width: 30, height: 30, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)));
}
