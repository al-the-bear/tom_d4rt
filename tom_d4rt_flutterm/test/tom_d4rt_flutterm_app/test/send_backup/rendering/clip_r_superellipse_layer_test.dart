import 'package:flutter/material.dart';

/// Deep visual demo for rounded superellipse clipping
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Superellipse Clip')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Rounded Superellipse', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 8),
    Text('Squircle-like corners', style: TextStyle(color: Colors.grey)),
    SizedBox(height: 16),
    Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _ShapeDemo('Standard', Colors.blue, BorderRadius.circular(20)),
      _ShapeDemo('Superellipse', Colors.orange, BorderRadius.circular(20)),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Superellipse creates iOS-style smooth corners between flat edges and rounded corners', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
  ])));
}

class _ShapeDemo extends StatelessWidget {
  final String label; final Color color; final BorderRadius radius;
  const _ShapeDemo(this.label, this.color, this.radius);
  @override Widget build(BuildContext context) => Column(children: [
    Container(width: 100, height: 100, decoration: BoxDecoration(color: color, borderRadius: radius)),
    SizedBox(height: 8),
    Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
  ]);
}
