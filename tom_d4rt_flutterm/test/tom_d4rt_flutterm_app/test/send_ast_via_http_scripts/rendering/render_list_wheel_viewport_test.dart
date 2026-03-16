import 'package:flutter/material.dart';

/// Deep visual demo for RenderListWheelViewport
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ListWheelViewport')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Wheel Scroll Effect', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: ListWheelScrollView(itemExtent: 60, diameterRatio: 1.5, perspective: 0.003,
        children: List.generate(20, (i) => Container(margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.withOpacity(0.2 + (i % 5) * 0.15), borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('Item ${i + 1}', style: TextStyle(fontWeight: FontWeight.bold)))))))),
    SizedBox(height: 8),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Creates iOS picker-style 3D wheel effect', style: TextStyle(fontSize: 11))),
  ])));
}
