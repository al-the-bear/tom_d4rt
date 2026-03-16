import 'package:flutter/material.dart';

/// Deep visual demo for semantics package classes overview
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Semantics Classes')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('flutter/semantics.dart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace')),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _ClassTile('SemanticsNode', 'Node in semantics tree', Colors.blue),
      _ClassTile('SemanticsData', 'Immutable node data', Colors.green),
      _ClassTile('SemanticsConfiguration', 'Mutable config builder', Colors.orange),
      _ClassTile('SemanticsOwner', 'Tree owner/manager', Colors.purple),
      Divider(),
      _ClassTile('SemanticsBinding', 'Platform binding', Colors.teal),
      _ClassTile('SemanticsHandle', 'Tree access handle', Colors.red),
      Divider(),
      _ClassTile('Semantics (widget)', 'Flutter widget', Colors.indigo),
      _ClassTile('SemanticsProperties', 'Property container', Colors.brown),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Accessibility primitives for screen readers', style: TextStyle(fontSize: 11))),
  ])));
}

class _ClassTile extends StatelessWidget {
  final String name; final String desc; final Color color;
  const _ClassTile(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => ListTile(
    leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(Icons.class_, color: color, size: 20)),
    title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(desc),
  );
}
