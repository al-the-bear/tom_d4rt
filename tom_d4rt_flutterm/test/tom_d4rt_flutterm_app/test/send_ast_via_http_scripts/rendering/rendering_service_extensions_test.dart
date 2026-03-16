import 'package:flutter/material.dart';

/// Deep visual demo for rendering service extensions
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Service Extensions')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Debug Service Extensions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _ExtCard('debugPaint', 'Show render box boundaries', Colors.blue),
      _ExtCard('debugPaintSizeEnabled', 'Show size info', Colors.orange),
      _ExtCard('profileRenderObjectLayouts', 'Track layout calls', Colors.green),
      _ExtCard('profileRenderObjectPaints', 'Track paint calls', Colors.purple),
      _ExtCard('repaintRainbow', 'Rainbow on repaint', Colors.red),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Enabled via DevTools or dart:developer extensions', style: TextStyle(fontSize: 11))),
  ])));
}

class _ExtCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _ExtCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.bug_report, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 11))]))]));
}
