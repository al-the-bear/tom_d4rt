import 'package:flutter/material.dart';

/// Deep visual demo for SliverHitTestEntry
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Hit Entry')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverHitTestEntry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.touch_app, size: 48, color: Colors.red),
        SizedBox(height: 12),
        Text('Hit Test Result Entry', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _Field('target', 'RenderSliver - Hit sliver'),
        _Field('mainAxisPosition', 'double - Scroll axis pos'),
        _Field('crossAxisPosition', 'double - Cross axis pos'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Stores sliver hit test information', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
