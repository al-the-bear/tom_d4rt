import 'package:flutter/material.dart';

/// Deep visual demo for RenderSizedOverflowBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SizedOverflowBox')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Fixed Size + Overflow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(width: 200, height: 100, decoration: BoxDecoration(border: Border.all(color: Colors.grey, style: BorderStyle.solid), borderRadius: BorderRadius.circular(8)),
      child: SizedOverflowBox(size: Size(200, 100), alignment: Alignment.topLeft,
        child: Container(width: 250, height: 150, decoration: BoxDecoration(color: Colors.blue.withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('250x150 in 200x100', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))))),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• size: The size to report to parent', style: TextStyle(fontSize: 11)),
        Text('• Child can overflow this size', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
