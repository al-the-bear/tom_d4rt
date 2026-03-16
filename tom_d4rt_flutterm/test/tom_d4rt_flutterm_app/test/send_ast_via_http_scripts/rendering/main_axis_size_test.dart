import 'package:flutter/material.dart';

/// Deep visual demo for MainAxisSize enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MainAxisSize')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Main Axis Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 20),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('MainAxisSize.max', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          child: Row(mainAxisSize: MainAxisSize.max, children: [_Chip(Colors.blue), _Chip(Colors.blue.shade300)])),
        SizedBox(height: 4),
        Text('Expands to fill available space', style: TextStyle(fontSize: 11)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('MainAxisSize.min', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [_Chip(Colors.orange), _Chip(Colors.orange.shade300)])),
        SizedBox(height: 4),
        Text('Shrinks to fit children', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _Chip extends StatelessWidget {
  final Color color;
  const _Chip(this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
    child: Text('Item', style: TextStyle(color: Colors.white)));
}
