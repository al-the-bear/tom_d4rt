import 'package:flutter/material.dart';

/// Deep visual demo for RenderAndroidView
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Android View')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Android Platform View', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green, width: 2)),
      child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.android, size: 80, color: Colors.green),
        SizedBox(height: 16),
        Text('Native Android View', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 8),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8)),
          child: Text('Maps, WebView, Camera, etc.', style: TextStyle(fontSize: 12))),
      ])))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Rendering modes:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Virtual Display (older)', style: TextStyle(fontSize: 11)),
        Text('• Hybrid Composition (newer)', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
