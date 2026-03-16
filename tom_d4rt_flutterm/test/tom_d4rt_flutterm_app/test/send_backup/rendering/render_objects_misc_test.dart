import 'package:flutter/material.dart';

/// Deep visual demo for miscellaneous render objects
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Misc RenderObjects')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Other Render Objects', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _MiscCard('RenderOffstage', 'Hidden but keeps state', Colors.grey),
      _MiscCard('RenderOpacity', 'Alpha blending', Colors.blue),
      _MiscCard('RenderTransform', 'Matrix transforms', Colors.green),
      _MiscCard('RenderFittedBox', 'Scale to fit', Colors.orange),
      _MiscCard('RenderCustomPaint', 'Custom drawing', Colors.purple),
      _MiscCard('RenderRepaintBoundary', 'Cache layer', Colors.red),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Utility render objects for effects and optimization', style: TextStyle(fontSize: 11))),
  ])));
}

class _MiscCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _MiscCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.settings_applications, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
