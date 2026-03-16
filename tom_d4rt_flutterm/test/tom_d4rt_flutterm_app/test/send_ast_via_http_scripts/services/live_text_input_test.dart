import 'package:flutter/material.dart';

/// Deep visual demo for Live Text input
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Live Text')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Live Text Input', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.camera_alt, size: 48, color: Colors.blue),
        SizedBox(height: 12),
        Text('Camera Text Recognition', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Scan text from physical objects using camera', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        SizedBox(height: 12),
        Container(height: 80, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Icon(Icons.document_scanner, size: 40, color: Colors.grey.shade400))),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('iOS 15+ and macOS Monterey+ feature', style: TextStyle(fontSize: 11))),
  ])));
}
