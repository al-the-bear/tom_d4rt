import 'package:flutter/material.dart';

/// Deep visual demo for AndroidPointerCoords
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Pointer Coords')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('AndroidPointerCoords', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lightGreen.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Stack(children: [
            Positioned(left: 60, top: 40, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.lightGreen.shade300, shape: BoxShape.circle))),
            Positioned(left: 85, top: 35, child: Text('(x, y)', style: TextStyle(fontSize: 10, color: Colors.grey))),
          ])),
        SizedBox(height: 16),
        _Field('orientation', 'Touch angle'),
        _Field('pressure', 'Touch pressure'),
        _Field('size', 'Touch size'),
        _Field('toolMajor/Minor', 'Tool dimensions'),
        _Field('touchMajor/Minor', 'Touch area dimensions'),
        _Field('x, y', 'Position coordinates'),
      ])),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 2), padding: EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 9)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
