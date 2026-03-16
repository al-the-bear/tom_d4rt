import 'package:flutter/material.dart';

/// Deep visual demo for UIKitView rendering
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('UIKitView')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('iOS Native View', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue, width: 2)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.phone_iphone, size: 64, color: Colors.blue),
        SizedBox(height: 16),
        Text('UiKitView', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 8),
        Text('Embeds iOS native UIView', style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 16),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Text("viewType: 'myNativeView'", style: TextStyle(fontFamily: 'monospace', fontSize: 11))),
      ]))),
    SizedBox(height: 8),
    Text('Platform-specific: iOS only', style: TextStyle(fontSize: 11, color: Colors.grey)),
  ])));
}
