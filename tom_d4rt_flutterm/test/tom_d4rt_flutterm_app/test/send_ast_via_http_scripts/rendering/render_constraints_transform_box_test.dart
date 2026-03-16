import 'package:flutter/material.dart';

/// Deep visual demo for RenderConstraintsTransformBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Constraints Transform')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Constraint Transformation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: UnconstrainedBox(constrainedAxis: Axis.horizontal,
        child: Container(width: 150, height: 200, decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.transform, color: Colors.white, size: 48),
            Text('Transformed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ])))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Transform options:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• constrainedAxis: Lock one axis', style: TextStyle(fontSize: 11)),
        Text('• textDirection: Affects alignment', style: TextStyle(fontSize: 11)),
        Text('• alignment: Position within bounds', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
