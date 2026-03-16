import 'package:flutter/material.dart';

/// Deep visual demo for LayerHandle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('LayerHandle')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Reference Handle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _HandleBox('Handle', Icons.gesture),
          Container(width: 40, height: 2, color: Colors.purple),
          _HandleBox('Layer', Icons.layers),
        ]),
        SizedBox(height: 16),
        Text('Handle maintains a reference to a layer', style: TextStyle(fontSize: 12)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('LayerHandle<T extends Layer>:', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
        SizedBox(height: 8),
        Text('• layer getter/setter', style: TextStyle(fontSize: 11)),
        Text('• Automatically manages ref counting', style: TextStyle(fontSize: 11)),
        Text('• Set to null when done', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _HandleBox extends StatelessWidget {
  final String label; final IconData icon;
  const _HandleBox(this.label, this.icon);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
    child: Column(children: [Icon(icon, color: Colors.purple), SizedBox(height: 4), Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))]));
}
