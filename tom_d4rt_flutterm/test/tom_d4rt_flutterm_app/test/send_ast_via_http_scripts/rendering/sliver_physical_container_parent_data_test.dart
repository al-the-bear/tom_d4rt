import 'package:flutter/material.dart';

/// Deep visual demo for SliverPhysicalContainerParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Physical Container')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverPhysicalContainerParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.view_in_ar, size: 48, color: Colors.deepPurple),
        SizedBox(height: 12),
        Text('Physical Layout Data', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text('Stores paint offset for children positioned in physical (paint) coordinate space', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Text('paintOffset: Offset(x, y)', style: TextStyle(fontFamily: 'monospace', fontSize: 10))),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used for positioned sliver children', style: TextStyle(fontSize: 11))),
  ])));
}
