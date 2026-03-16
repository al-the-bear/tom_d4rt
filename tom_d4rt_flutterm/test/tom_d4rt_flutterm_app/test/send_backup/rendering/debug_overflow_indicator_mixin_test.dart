import 'package:flutter/material.dart';

/// Deep visual demo for overflow debug indicators
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Overflow Indicators')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Debug Overflow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(width: 200, height: 100, decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Stack(children: [
        Positioned(top: -10, left: 10, child: Container(width: 40, height: 40, color: Colors.blue)),
        Positioned(top: 30, right: -20, child: Container(width: 60, height: 60, color: Colors.orange)),
        Positioned(right: 0, top: 0, child: Container(width: 30, height: 120, color: Colors.black.withOpacity(0.5),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int i = 0; i < 5; i++) Container(margin: EdgeInsets.symmetric(vertical: 2),
              child: Container(width: 20, height: 2, color: Colors.yellow)),
          ]))),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Container(width: 20, height: 20, color: Colors.black, child: Center(child: Container(width: 16, height: 2, color: Colors.yellow))),
        SizedBox(width: 12),
        Expanded(child: Text('Yellow/black stripes indicate overflow in debug mode', style: TextStyle(fontSize: 12))),
      ])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by RenderFlex, RenderStack, etc. to show layout overflow errors visually', style: TextStyle(fontSize: 11))),
  ])));
}
