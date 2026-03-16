import 'package:flutter/material.dart';

/// Deep visual demo for PlatformViewRenderBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PlatformView RenderBox')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('PlatformView RenderBox', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
      child: Center(child: Container(width: 250, height: 180, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.web, size: 48, color: Colors.blue),
          SizedBox(height: 8),
          Text('Native Platform View', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('WebView, Maps, etc.', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ]))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('RenderBox that hosts a native platform view within Flutter', style: TextStyle(fontSize: 11))),
  ])));
}
