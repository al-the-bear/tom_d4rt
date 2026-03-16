import 'package:flutter/material.dart';

/// Deep visual demo for ListWheelChildManager
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Wheel Child Manager')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('List Wheel Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: ListWheelScrollView(itemExtent: 50, diameterRatio: 1.5, children: List.generate(20, (i) => Container(margin: EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2 + (i % 5) * 0.15), borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text('Item $i', style: TextStyle(fontWeight: FontWeight.bold)))))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Manager responsibilities:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• childCount: Total items', style: TextStyle(fontSize: 11)),
        Text('• createChild(index): Build item', style: TextStyle(fontSize: 11)),
        Text('• removeChild(): Dispose item', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
