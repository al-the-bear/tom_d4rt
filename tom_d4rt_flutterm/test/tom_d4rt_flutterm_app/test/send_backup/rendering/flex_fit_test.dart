import 'package:flutter/material.dart';

/// Deep visual demo for FlexFit enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FlexFit')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Flex Fit Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 20),
    Text('FlexFit.tight', style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Container(height: 60, decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(children: [
        Expanded(child: Container(color: Colors.blue, child: Center(child: Text('Expand', style: TextStyle(color: Colors.white))))),
        Expanded(child: Container(color: Colors.orange, child: Center(child: Text('Expand', style: TextStyle(color: Colors.white))))),
      ])),
    SizedBox(height: 20),
    Text('FlexFit.loose', style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Container(height: 60, decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(children: [
        Flexible(fit: FlexFit.loose, child: Container(color: Colors.green, padding: EdgeInsets.all(8), child: Text('Min', style: TextStyle(color: Colors.white)))),
        Flexible(fit: FlexFit.loose, child: Container(color: Colors.purple, padding: EdgeInsets.all(8), child: Text('Min', style: TextStyle(color: Colors.white)))),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text('tight: Fill all available space', style: TextStyle(fontSize: 11)),
        Text('loose: Use only needed space', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
