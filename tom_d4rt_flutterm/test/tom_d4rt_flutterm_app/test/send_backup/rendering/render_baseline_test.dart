import 'package:flutter/material.dart';

/// Deep visual demo for RenderBaseline
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Baseline')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Baseline Alignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('Big', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Text('Medium', style: TextStyle(fontSize: 24)),
          SizedBox(width: 8),
          Text('Small', style: TextStyle(fontSize: 14)),
        ]),
        SizedBox(height: 8),
        Container(height: 2, color: Colors.amber),
        Text('Text baseline alignment', style: TextStyle(fontSize: 11, color: Colors.amber.shade700)),
      ])),
    SizedBox(height: 24),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Baseline(baseline: 50, baselineType: TextBaseline.alphabetic,
        child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: Text('At 50px baseline', style: TextStyle(color: Colors.white))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('RenderBaseline positions child at specific baseline distance', style: TextStyle(fontSize: 11))),
  ])));
}
