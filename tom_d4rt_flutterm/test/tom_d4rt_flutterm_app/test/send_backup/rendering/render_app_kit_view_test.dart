import 'package:flutter/material.dart';

/// Deep visual demo for RenderAppKitView (macOS)
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AppKit View')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('macOS Native View', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey, width: 2)),
      child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.desktop_mac, size: 80, color: Colors.grey.shade700),
        SizedBox(height: 16),
        Text('Native macOS View', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 8),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
          child: Text('NSView embedding', style: TextStyle(fontSize: 12))),
      ])))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('AppKit integration:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• RenderAppKitView hosts NSView', style: TextStyle(fontSize: 11)),
        Text('• Similar to Android/iOS PlatformViews', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
