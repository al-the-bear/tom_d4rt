import 'package:flutter/material.dart';

/// Deep visual demo for render layers pipeline
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Layers Pipeline')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Composition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _LayerStep('Root', 'TransformLayer'),
        Icon(Icons.arrow_downward, color: Colors.indigo),
        _LayerStep('Child 1', 'ClipRectLayer'),
        _LayerStep('Child 2', 'OpacityLayer'),
        Icon(Icons.arrow_downward, color: Colors.indigo),
        _LayerStep('Leaf', 'PictureLayer'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Layers form a tree that gets composited by Skia/Impeller', style: TextStyle(fontSize: 11))),
  ])));
}

class _LayerStep extends StatelessWidget {
  final String level; final String type;
  const _LayerStep(this.level, this.type);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Text(level, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)), Spacer(), Text(type, style: TextStyle(fontSize: 11, fontFamily: 'monospace'))]));
}
