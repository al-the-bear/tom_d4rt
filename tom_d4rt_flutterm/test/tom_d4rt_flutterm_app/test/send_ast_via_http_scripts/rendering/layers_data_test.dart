import 'package:flutter/material.dart';

/// Deep visual demo for layer data types
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Layers Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Data Structures', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _DataCard('OffsetLayer', 'offset: Offset', Colors.blue),
      _DataCard('ClipRectLayer', 'clipRect: Rect', Colors.orange),
      _DataCard('OpacityLayer', 'alpha: int (0-255)', Colors.green),
      _DataCard('TransformLayer', 'transform: Matrix4', Colors.purple),
      _DataCard('ColorFilterLayer', 'colorFilter: ColorFilter', Colors.red),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Each layer type stores specific rendering data', style: TextStyle(fontSize: 11))),
  ])));
}

class _DataCard extends StatelessWidget {
  final String name; final String data; final Color color;
  const _DataCard(this.name, this.data, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Row(children: [Icon(Icons.layers, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(data, style: TextStyle(fontSize: 11, fontFamily: 'monospace'))]))]));
}
