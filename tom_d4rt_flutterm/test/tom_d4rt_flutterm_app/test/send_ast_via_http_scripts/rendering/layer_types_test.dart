import 'package:flutter/material.dart';

/// Deep visual demo for various layer types
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Layer Types')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Hierarchy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 12),
    Expanded(child: ListView(children: [
      _TypeCard('Layer', 'Base class', Icons.layers_outlined, Colors.grey),
      _TypeCard('ContainerLayer', 'Has children', Icons.folder, Colors.blue),
      _TypeCard('OffsetLayer', 'Offset transform', Icons.open_with, Colors.green),
      _TypeCard('ClipRectLayer', 'Rectangular clip', Icons.crop, Colors.orange),
      _TypeCard('ClipRRectLayer', 'Rounded rect clip', Icons.crop_din, Colors.purple),
      _TypeCard('ClipPathLayer', 'Path clip', Icons.architecture, Colors.red),
      _TypeCard('OpacityLayer', 'Alpha blending', Icons.opacity, Colors.teal),
      _TypeCard('TransformLayer', 'Matrix transform', Icons.transform, Colors.indigo),
    ])),
  ])));
}

class _TypeCard extends StatelessWidget {
  final String name; final String desc; final IconData icon; final Color color;
  const _TypeCard(this.name, this.desc, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(icon, color: color, size: 20), SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
