import 'package:flutter/material.dart';

/// Deep visual demo for BoxHitTestEntry
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BoxHitTestEntry')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Hit Test Entry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    GestureDetector(onTapDown: (details) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Local: ${details.localPosition}'))),
      child: Container(height: 150, decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange)),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.touch_app, size: 40, color: Colors.orange), Text('Tap anywhere', style: TextStyle(color: Colors.orange))])))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('BoxHitTestEntry contains:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• target: RenderBox that was hit', style: TextStyle(fontSize: 11)),
        Text('• localPosition: Offset in box coordinates', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
