import 'package:flutter/material.dart';

/// Deep visual demo for rendering package classes overview
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Rendering Classes')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('flutter/rendering.dart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace')),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _ClassTile('RenderObject', 'Base render node', Colors.blue, true),
      _ClassTile('RenderBox', 'Box protocol render', Colors.green, false),
      _ClassTile('RenderSliver', 'Sliver protocol render', Colors.orange, false),
      Divider(),
      _ClassTile('Layer', 'Compositing layer', Colors.purple, true),
      _ClassTile('ContainerLayer', 'Layer with children', Colors.teal, false),
      Divider(),
      _ClassTile('BoxConstraints', 'Box layout constraints', Colors.red, false),
      _ClassTile('SliverConstraints', 'Sliver constraints', Colors.indigo, false),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Low-level rendering primitives', style: TextStyle(fontSize: 11))),
  ])));
}

class _ClassTile extends StatelessWidget {
  final String name; final String desc; final Color color; final bool isBase;
  const _ClassTile(this.name, this.desc, this.color, this.isBase);
  @override Widget build(BuildContext context) => ListTile(
    leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(isBase ? Icons.category : Icons.class_, color: color, size: 20)),
    title: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), if (isBase) Container(margin: EdgeInsets.only(left: 8), padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(4)), child: Text('base', style: TextStyle(color: Colors.white, fontSize: 9)))]),
    subtitle: Text(desc),
  );
}
