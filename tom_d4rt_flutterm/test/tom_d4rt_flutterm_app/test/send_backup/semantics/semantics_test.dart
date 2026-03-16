import 'package:flutter/material.dart';

/// Deep visual demo for Semantics widget
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Semantics Widget')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Semantics(label: 'Example accessible button', button: true, enabled: true,
      child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
        child: Text('Tap Me', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
    SizedBox(height: 24),
    Text('Semantics Widget Properties', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 12),
    Expanded(child: ListView(children: [
      _PropCard('label', 'Screen reader text', Colors.blue),
      _PropCard('value', 'Current value', Colors.green),
      _PropCard('hint', 'Usage hint', Colors.orange),
      _PropCard('button', 'Is button?', Colors.purple),
      _PropCard('enabled', 'Interactive?', Colors.teal),
      _PropCard('checked', 'Toggle state', Colors.red),
      _PropCard('selected', 'Selection state', Colors.indigo),
    ])),
  ])));
}

class _PropCard extends StatelessWidget {
  final String name; final String desc; final Color color;
  const _PropCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: color, radius: 16, child: Icon(Icons.label, color: Colors.white, size: 16)), title: Text(name, style: TextStyle(fontFamily: 'monospace')), subtitle: Text(desc)));
}
