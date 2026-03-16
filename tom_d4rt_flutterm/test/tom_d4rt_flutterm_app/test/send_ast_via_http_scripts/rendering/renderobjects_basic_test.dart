import 'package:flutter/material.dart';

/// Deep visual demo for basic RenderObjects
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Basic RenderObjects')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Core Render Objects', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: GridView.count(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 1.3, children: [
      _ROCard('RenderBox', 'Box constraints', Colors.blue),
      _ROCard('RenderSliver', 'Scroll slivers', Colors.green),
      _ROCard('RenderParagraph', 'Text layout', Colors.orange),
      _ROCard('RenderImage', 'Image display', Colors.purple),
      _ROCard('RenderFlex', 'Row/Column', Colors.red),
      _ROCard('RenderStack', 'Stack layout', Colors.teal),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Foundation objects for layout and painting', style: TextStyle(fontSize: 11))),
  ])));
}

class _ROCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _ROCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.crop_square, color: color, size: 32), SizedBox(height: 4), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
