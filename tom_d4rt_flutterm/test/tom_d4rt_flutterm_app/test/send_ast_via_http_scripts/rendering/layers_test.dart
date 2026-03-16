import 'package:flutter/material.dart';

/// Deep visual demo for render layers
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Render Layers')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Tree', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _LayerNode('ContainerLayer', 0),
        Padding(padding: EdgeInsets.only(left: 20), child: Column(children: [
          _LayerNode('OpacityLayer', 1),
          Padding(padding: EdgeInsets.only(left: 20), child: Column(children: [
            _LayerNode('OffsetLayer', 2),
            _LayerNode('ClipRectLayer', 2),
          ])),
        ])),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Layer types:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• ContainerLayer: holds children', style: TextStyle(fontSize: 11)),
        Text('• OffsetLayer: applies offset', style: TextStyle(fontSize: 11)),
        Text('• ClipRectLayer: clips to rect', style: TextStyle(fontSize: 11)),
        Text('• OpacityLayer: applies alpha', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _LayerNode extends StatelessWidget {
  final String name; final int depth;
  const _LayerNode(this.name, this.depth);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1 + depth * 0.15), borderRadius: BorderRadius.circular(8)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.layers, size: 16, color: Colors.blue), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]));
}
