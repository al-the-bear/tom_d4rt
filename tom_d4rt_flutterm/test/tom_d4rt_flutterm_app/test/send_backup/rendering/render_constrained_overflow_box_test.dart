import 'package:flutter/material.dart';

/// Deep visual demo for RenderConstrainedOverflowBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Constrained Overflow')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Overflow with Constraints', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2), borderRadius: BorderRadius.circular(12)),
      child: OverflowBox(maxWidth: 300, maxHeight: 200, minWidth: 100, minHeight: 100,
        child: Container(width: 200, height: 150, decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Child ignores parent constraints', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text('but follows min/max limits', style: TextStyle(color: Colors.white70, fontSize: 11)),
          ])))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• minWidth, maxWidth', style: TextStyle(fontSize: 11)),
        Text('• minHeight, maxHeight', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
