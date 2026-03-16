import 'package:flutter/material.dart';

/// Deep visual demo for VerticalCaretMovementRun
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Caret Movement')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('VerticalCaretMovementRun', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.indigo)),
          child: Stack(children: [
            Positioned(left: 16, top: 10, child: Text('Line 1: short', style: TextStyle(fontSize: 12))),
            Positioned(left: 16, top: 35, child: Text('Line 2: this is longer', style: TextStyle(fontSize: 12))),
            Positioned(left: 16, top: 60, child: Text('Line 3: med', style: TextStyle(fontSize: 12))),
            Positioned(left: 80, top: 8, bottom: 35, child: Container(width: 2, color: Colors.indigo.withAlpha(128))),
            Positioned(left: 78, top: 35, child: Container(width: 6, height: 20, color: Colors.indigo)),
          ])),
        SizedBox(height: 12),
        Text('Maintains horizontal position during ↑↓ navigation', textAlign: TextAlign.center, style: TextStyle(fontSize: 11)),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Iterator for up/down cursor movement', style: TextStyle(fontSize: 11))),
  ])));
}
