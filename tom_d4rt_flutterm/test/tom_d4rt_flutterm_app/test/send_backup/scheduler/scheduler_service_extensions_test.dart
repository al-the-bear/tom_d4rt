import 'package:flutter/material.dart';

/// Deep visual demo for Scheduler service extensions
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Scheduler Service Extensions')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.extension, size: 48, color: Colors.purple),
    SizedBox(height: 8),
    Text('Service Extensions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _ExtCard('ext.flutter.timeDilation', 'Control animation speed', Colors.blue),
      _ExtCard('ext.flutter.reassemble', 'Trigger hot reload', Colors.orange),
      _ExtCard('ext.flutter.debugDumpApp', 'Dump widget tree', Colors.green),
      _ExtCard('ext.flutter.debugDumpRenderTree', 'Dump render tree', Colors.teal),
      _ExtCard('ext.flutter.debugDumpLayerTree', 'Dump layer tree', Colors.purple),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Access via:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• DevTools', style: TextStyle(fontSize: 11)),
        Text('• Observatory', style: TextStyle(fontSize: 11)),
        Text('• flutter run --debug', style: TextStyle(fontSize: 11)),
      ]))
  ])));
}

class _ExtCard extends StatelessWidget {
  final String name; final String desc; final Color color;
  const _ExtCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: color, child: Icon(Icons.code, color: Colors.white, size: 18)), title: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 12)), subtitle: Text(desc)));
}
