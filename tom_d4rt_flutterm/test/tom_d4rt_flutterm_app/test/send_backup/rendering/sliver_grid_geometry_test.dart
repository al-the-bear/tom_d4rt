import 'package:flutter/material.dart';

/// Deep visual demo for SliverGridGeometry
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Grid Geometry')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverGridGeometry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: GridView.count(crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4, padding: EdgeInsets.all(8),
            children: [for (var i = 0; i < 6; i++) Container(color: Colors.purple.shade200, child: Center(child: Text('${i + 1}')))])),
        SizedBox(height: 16),
        _Field('scrollOffset', 'Position on scroll axis'),
        _Field('crossAxisOffset', 'Position on cross axis'),
        _Field('mainAxisExtent', 'Size on scroll axis'),
        _Field('crossAxisExtent', 'Size on cross axis'),
      ]))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
