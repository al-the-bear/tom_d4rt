import 'package:flutter/material.dart';

/// Deep visual demo for AnnotatedRegionLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AnnotatedRegionLayer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Annotations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(height: 200, decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
      child: Stack(children: [
        Positioned.fill(child: Container(color: Colors.blue.withOpacity(0.1), child: Center(child: Text('Region A', style: TextStyle(color: Colors.blue))))),
        Positioned(top: 40, left: 40, child: Container(width: 100, height: 100, color: Colors.orange.withOpacity(0.3), child: Center(child: Text('Region B')))),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('AnnotatedRegionLayer<T>:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Associates data with layer regions', style: TextStyle(fontSize: 11)),
        Text('• Used for SystemUiOverlayStyle', style: TextStyle(fontSize: 11)),
        Text('• Supports hit-testing for annotations', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
