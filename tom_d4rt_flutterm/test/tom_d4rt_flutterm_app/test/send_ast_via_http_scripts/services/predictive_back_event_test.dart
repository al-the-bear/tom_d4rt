import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for PredictiveBackEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PredictiveBackEvent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Android 13+ Back Gesture', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.swipe_left_alt, size: 48, color: Colors.teal),
        SizedBox(height: 12),
        Text('Predictive Back', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 16),
        _Property('touchOffset', 'Offset', 'Touch position during gesture'),
        _Property('progress', 'double', '0.0 to 1.0 gesture progress'),
        _Property('swipeEdge', 'SwipeEdge', 'left or right edge'),
        SizedBox(height: 16),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(children: [
            Text('SwipeEdge Values:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Chip(label: Text('left'), backgroundColor: Colors.blue.shade100),
              SizedBox(width: 8),
              Chip(label: Text('right'), backgroundColor: Colors.green.shade100),
            ]),
          ])),
      ]))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Android 13+ only - enables animated back gestures', style: TextStyle(fontSize: 10))),
  ])));
}

class _Property extends StatelessWidget {
  final String name; final String type; final String desc;
  const _Property(this.name, this.type, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), SizedBox(width: 8), Text(type, style: TextStyle(color: Colors.teal, fontSize: 9)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
