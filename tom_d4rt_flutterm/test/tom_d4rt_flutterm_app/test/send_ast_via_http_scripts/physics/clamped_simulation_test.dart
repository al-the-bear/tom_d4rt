import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Deep visual demo for ClampedSimulation
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ClampedSimulation')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)), child: Text('MIN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          Expanded(child: Container(margin: EdgeInsets.symmetric(horizontal: 8), height: 4, color: Colors.teal)),
          Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)), child: Text('MAX', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ]),
        SizedBox(height: 12),
        Container(width: 30, height: 30, decoration: BoxDecoration(color: Colors.teal, shape: BoxShape.circle), child: Icon(Icons.circle, color: Colors.white, size: 16)),
        SizedBox(height: 8),
        Text('Value constrained to bounds', style: TextStyle(fontWeight: FontWeight.bold)),
      ])),
    SizedBox(height: 20),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('ClampedSimulation wraps any Simulation', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Parameters:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text('• simulation: inner Simulation', style: TextStyle(fontSize: 11)),
        Text('• xMin: minimum bound (default: double.negativeInfinity)', style: TextStyle(fontSize: 11)),
        Text('• xMax: maximum bound (default: double.infinity)', style: TextStyle(fontSize: 11)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [Icon(Icons.info, color: Colors.orange), SizedBox(width: 8), Expanded(child: Text('Use to prevent scrolling past boundaries', style: TextStyle(fontSize: 12)))]))
  ])));
}
