import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Deep visual demo for DecorationPosition enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('DecorationPosition')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Decoration Position', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 20),
    _PositionDemo(DecorationPosition.background, 'Background', 'Decoration drawn BEHIND child'),
    SizedBox(height: 16),
    _PositionDemo(DecorationPosition.foreground, 'Foreground', 'Decoration drawn OVER child'),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used in DecoratedBox widget to control paint order', style: TextStyle(fontSize: 12))),
  ])));
}

class _PositionDemo extends StatelessWidget {
  final DecorationPosition pos; final String name; final String desc;
  const _PositionDemo(this.pos, this.name, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: (pos == DecorationPosition.background ? Colors.blue : Colors.orange).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Stack(children: [
        if (pos == DecorationPosition.background) Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.blue.shade200, borderRadius: BorderRadius.circular(8))),
        Container(width: 60, height: 60, alignment: Alignment.center, child: Icon(Icons.star, size: 30)),
        if (pos == DecorationPosition.foreground) Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.orange.withOpacity(0.5), borderRadius: BorderRadius.circular(8))),
      ]),
      SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(desc, style: TextStyle(fontSize: 12))])),
    ]));
}
