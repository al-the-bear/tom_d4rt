import 'package:flutter/material.dart';

/// Deep visual demo for RenderShrinkWrappingViewport
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ShrinkWrap Viewport')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Shrink Wrapping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: ListView(shrinkWrap: true, children: List.generate(5, (i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
        child: Text('Item ${i + 1}'))))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('shrinkWrap: true', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        SizedBox(height: 4),
        Text('• Sizes to content', style: TextStyle(fontSize: 11)),
        Text('• Good for small lists in scrollable', style: TextStyle(fontSize: 11)),
        Text('• Slower than fixed viewport', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
