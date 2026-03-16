import 'package:flutter/material.dart';

/// Deep visual demo for SliverLogicalParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Logical Parent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverLogicalParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lime.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _Field('layoutOffset', 'Position in scroll space'),
        SizedBox(height: 12),
        Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Stack(children: [
            Positioned(left: 20, top: 10, child: Container(width: 120, height: 25, decoration: BoxDecoration(color: Colors.lime.shade100, borderRadius: BorderRadius.circular(4)), child: Center(child: Text('offset: 0', style: TextStyle(fontSize: 9))))),
            Positioned(left: 20, top: 40, child: Container(width: 120, height: 25, decoration: BoxDecoration(color: Colors.lime.shade200, borderRadius: BorderRadius.circular(4)), child: Center(child: Text('offset: 30', style: TextStyle(fontSize: 9))))),
            Positioned(left: 20, top: 70, child: Container(width: 120, height: 25, decoration: BoxDecoration(color: Colors.lime.shade300, borderRadius: BorderRadius.circular(4)), child: Center(child: Text('offset: 60', style: TextStyle(fontSize: 9))))),
          ])),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Stores logical offset from sliver start', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
