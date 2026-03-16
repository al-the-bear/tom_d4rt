import 'package:flutter/material.dart';

/// Deep visual demo for RenderErrorBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ErrorBox')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Error Display', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red, width: 2)),
      child: Column(children: [
        Icon(Icons.error_outline, size: 64, color: Colors.red),
        SizedBox(height: 12),
        Text('RenderErrorBox', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
        SizedBox(height: 8),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
          child: Text('Exception during build/layout/paint', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'monospace', fontSize: 11))),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Shown when a RenderObject throws - the red/yellow error screen', style: TextStyle(fontSize: 11))),
  ])));
}
