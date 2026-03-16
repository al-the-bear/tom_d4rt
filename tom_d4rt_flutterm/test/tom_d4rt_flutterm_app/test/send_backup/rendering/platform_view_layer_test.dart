import 'package:flutter/material.dart';

/// Deep visual demo for PlatformViewLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PlatformViewLayer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Platform View Layer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2), borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Center(child: Container(width: 200, height: 150, decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green, width: 2)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.android, size: 48, color: Colors.green), Text('Native View', style: TextStyle(fontWeight: FontWeight.bold))]))),
        Positioned(top: 8, left: 8, child: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
          child: Text('Flutter Overlay', style: TextStyle(color: Colors.white, fontSize: 12)))),
      ]))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• rect: Placement rectangle', style: TextStyle(fontSize: 11)),
        Text('• viewId: Native view identifier', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
