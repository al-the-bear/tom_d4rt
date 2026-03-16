import 'package:flutter/material.dart';

/// Deep visual demo for ColorFilterLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ColorFilterLayer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Color Filter Layers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: GridView.count(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, children: [
      _FilterDemo('Original', null),
      _FilterDemo('Grayscale', ColorFilter.mode(Colors.grey, BlendMode.saturation)),
      _FilterDemo('Sepia', ColorFilter.mode(Colors.brown.shade200, BlendMode.modulate)),
      _FilterDemo('Invert', ColorFilter.matrix([
        -1, 0, 0, 0, 255,
        0, -1, 0, 0, 255,
        0, 0, -1, 0, 255,
        0, 0, 0, 1, 0,
      ])),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Applies color transformations to subtree', style: TextStyle(fontSize: 11))),
  ])));
}

class _FilterDemo extends StatelessWidget {
  final String label; final ColorFilter? filter;
  const _FilterDemo(this.label, this.filter);
  @override Widget build(BuildContext context) => Column(children: [
    Expanded(child: ColorFiltered(colorFilter: filter ?? ColorFilter.mode(Colors.transparent, BlendMode.dst),
      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), gradient: LinearGradient(colors: [Colors.red, Colors.blue])),
        child: Center(child: Icon(Icons.photo, color: Colors.white, size: 40))))),
    SizedBox(height: 4),
    Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
  ]);
}
