import 'package:flutter/material.dart';

/// Deep visual demo for composite render objects
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Composite Rendering')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Composition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Stack(children: [
      Container(decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(12))),
      Positioned(top: 20, left: 20, child: _LayerBox('Layer 1', Colors.blue, 0.9)),
      Positioned(top: 60, left: 60, child: _LayerBox('Layer 2', Colors.orange, 0.8)),
      Positioned(top: 100, left: 100, child: _LayerBox('Layer 3', Colors.green, 0.7)),
    ])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Composite operations:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Opacity blending', style: TextStyle(fontSize: 11)),
        Text('• Clip path application', style: TextStyle(fontSize: 11)),
        Text('• Transform matrices', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _LayerBox extends StatelessWidget {
  final String name; final Color color; final double opacity;
  const _LayerBox(this.name, this.color, this.opacity);
  @override Widget build(BuildContext context) => Opacity(opacity: opacity,
    child: Container(width: 150, height: 100, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
      child: Center(child: Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))));
}
