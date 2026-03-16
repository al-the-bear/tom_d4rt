import 'package:flutter/material.dart';

/// Deep visual demo for SelectionPoint
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Point')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionPoint', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(height: 60, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Stack(children: [
            Positioned(left: 80, top: 10, child: Container(width: 4, height: 40, decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(2)))),
            Positioned(left: 72, top: 48, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle))),
          ])),
        SizedBox(height: 16),
        _Field('localPosition', 'Offset - Local coordinates'),
        _Field('lineHeight', 'double - Text line height'),
        _Field('handleType', 'TextSelectionHandleType'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Represents a selection handle position', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
