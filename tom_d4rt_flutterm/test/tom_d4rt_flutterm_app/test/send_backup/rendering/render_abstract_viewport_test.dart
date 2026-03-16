import 'package:flutter/material.dart';

/// Deep visual demo for RenderAbstractViewport
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Abstract Viewport')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Viewport Architecture', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(height: 150, decoration: BoxDecoration(border: Border.all(color: Colors.cyan, width: 2), borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(borderRadius: BorderRadius.circular(8), child: ListView.builder(itemCount: 20, itemBuilder: (_, i) => Container(height: 40, color: i.isEven ? Colors.cyan.shade100 : Colors.cyan.shade200, child: Center(child: Text('Item $i')))))),
        SizedBox(height: 12),
        Text('Viewport clips and scrolls content', style: TextStyle(fontWeight: FontWeight.bold)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Key method:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('getOffsetToReveal(target, alignment)', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
      ])),
  ])));
}
