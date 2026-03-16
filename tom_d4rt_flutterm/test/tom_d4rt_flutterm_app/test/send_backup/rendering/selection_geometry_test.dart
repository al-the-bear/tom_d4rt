import 'package:flutter/material.dart';

/// Deep visual demo for SelectionGeometry
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Geometry')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionGeometry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lime.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(height: 80, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.lime), borderRadius: BorderRadius.circular(8)),
          child: Stack(children: [
            Positioned(left: 50, top: 20, child: Container(width: 100, height: 24, color: Colors.lime.shade200)),
            Positioned(left: 48, top: 16, child: Container(width: 4, height: 32, color: Colors.lime.shade400)),
            Positioned(left: 148, top: 16, child: Container(width: 4, height: 32, color: Colors.lime.shade400)),
          ])),
        SizedBox(height: 16),
        _Field('startSelectionPoint', 'SelectionPoint - Start handle'),
        _Field('endSelectionPoint', 'SelectionPoint - End handle'),
        _Field('selectionRects', 'List<Rect> - Selection boxes'),
        _Field('status', 'SelectionStatus'),
        _Field('hasContent', 'bool - Has selectable content'),
      ]))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 9)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
