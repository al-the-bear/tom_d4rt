import 'package:flutter/material.dart';

/// Deep visual demo for SliverPhysicalParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Physical Parent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverPhysicalParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _Field('paintOffset', 'Offset for painting'),
        SizedBox(height: 12),
        Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Stack(children: [
            Container(margin: EdgeInsets.all(8), decoration: BoxDecoration(border: Border.all(color: Colors.pink.shade200, style: BorderStyle.solid, width: 2), borderRadius: BorderRadius.circular(4))),
            Positioned(left: 30, top: 30, child: Container(width: 80, height: 40, decoration: BoxDecoration(color: Colors.pink.shade200, borderRadius: BorderRadius.circular(4)), child: Center(child: Text('Child', style: TextStyle(fontSize: 10))))),
            Positioned(left: 12, top: 48, child: Text('→', style: TextStyle(fontSize: 14, color: Colors.pink))),
            Positioned(left: 50, top: 12, child: Text('↓', style: TextStyle(fontSize: 14, color: Colors.pink))),
          ])),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Offset from sliver origin to child paint point', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
