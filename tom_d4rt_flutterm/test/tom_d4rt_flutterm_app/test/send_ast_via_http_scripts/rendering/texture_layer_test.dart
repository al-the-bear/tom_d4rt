import 'package:flutter/material.dart';

/// Deep visual demo for TextureLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextureLayer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('External Texture', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.texture, size: 64, color: Colors.purple),
        SizedBox(height: 12),
        Text('TextureLayer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 8),
        _PropRow('textureId', 'Platform texture ID'),
        _PropRow('rect', 'Display bounds'),
        _PropRow('freeze', 'Pause updates'),
        _PropRow('filterQuality', 'Scaling quality'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Displays external textures like video/camera feeds', style: TextStyle(fontSize: 11))),
  ])));
}

class _PropRow extends StatelessWidget {
  final String name; final String desc;
  const _PropRow(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Row(children: [
    Text(name, style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 12)),
    Spacer(),
    Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey)),
  ]));
}
