import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Deep visual demo for BoundedFrictionSimulation
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BoundedFrictionSimulation')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(children: [Icon(Icons.first_page, color: Colors.red), Text('Min', style: TextStyle(fontWeight: FontWeight.bold))]),
          Expanded(child: Stack(alignment: Alignment.center, children: [
            Container(margin: EdgeInsets.symmetric(horizontal: 20), height: 8, decoration: BoxDecoration(color: Colors.green.shade200, borderRadius: BorderRadius.circular(4))),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.slow_motion_video, color: Colors.green),
              Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
              Icon(Icons.arrow_forward, color: Colors.green.shade300),
            ]),
          ])),
          Column(children: [Icon(Icons.last_page, color: Colors.red), Text('Max', style: TextStyle(fontWeight: FontWeight.bold))]),
        ]),
        SizedBox(height: 12),
        Text('Friction + Bounds', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Combines:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(children: [Icon(Icons.check, color: Colors.green, size: 16), Text(' Friction (velocity decay)', style: TextStyle(fontSize: 12))]),
        Row(children: [Icon(Icons.check, color: Colors.green, size: 16), Text(' Position bounds (min/max)', style: TextStyle(fontSize: 12))]),
        SizedBox(height: 8),
        Text('Parameters: drag, position, velocity, minX, maxX', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
      ])),
    Spacer(),
    Text('Used for bounded scroll physics', style: TextStyle(color: Colors.grey))
  ])));
}
