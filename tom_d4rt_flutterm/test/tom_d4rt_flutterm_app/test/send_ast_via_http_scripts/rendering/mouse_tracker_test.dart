import 'package:flutter/material.dart';

/// Deep visual demo for MouseTracker
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MouseTracker')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Mouse Region Tracking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: MouseRegion(
      onEnter: (_) {},
      onExit: (_) {},
      onHover: (_) {},
      child: Container(decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue)),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.mouse, size: 48, color: Colors.blue),
          SizedBox(height: 8),
          Text('Hover here', style: TextStyle(fontSize: 16)),
          Text('Tracks enter, exit, hover events', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ]))))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('MouseTracker manages mouse cursor updates and region callbacks', style: TextStyle(fontSize: 11))),
  ])));
}
