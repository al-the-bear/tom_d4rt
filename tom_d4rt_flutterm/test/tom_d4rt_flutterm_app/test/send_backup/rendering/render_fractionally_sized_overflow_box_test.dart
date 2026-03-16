import 'package:flutter/material.dart';

/// Deep visual demo for RenderFractionallySizedOverflowBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Fractional Overflow')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Fractional Sizing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2), borderRadius: BorderRadius.circular(12)),
      child: FractionallySizedBox(widthFactor: 0.8, heightFactor: 0.6,
        child: Container(decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('80% width', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text('60% height', style: TextStyle(color: Colors.white70)),
          ])))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• widthFactor: 0.0 to 1.0+', style: TextStyle(fontSize: 11)),
        Text('• heightFactor: 0.0 to 1.0+', style: TextStyle(fontSize: 11)),
        Text('Values > 1.0 cause overflow', style: TextStyle(fontSize: 10, color: Colors.grey)),
      ])),
  ])));
}
