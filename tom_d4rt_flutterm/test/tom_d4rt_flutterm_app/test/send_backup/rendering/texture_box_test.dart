import 'package:flutter/material.dart';

/// Deep visual demo for TextureBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Texture Box')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('RenderTexture / TextureBox', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.texture, size: 64, color: Colors.deepOrange),
        SizedBox(height: 16),
        Text('External Texture Rendering', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Displays GPU texture from external source (video, camera, etc.)', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        SizedBox(height: 16),
        _Field('textureId', 'int - Platform texture ID'),
        _Field('filterQuality', 'FilterQuality'),
        _Field('freeze', 'bool - Stop updates'),
      ]))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
