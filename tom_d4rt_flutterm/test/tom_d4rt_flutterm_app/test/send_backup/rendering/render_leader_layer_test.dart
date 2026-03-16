import 'package:flutter/material.dart';

/// Deep visual demo for RenderLeaderLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Leader Layer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Composited Transform', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Positioned(top: 80, left: 80, child: Container(width: 120, height: 80, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.star, color: Colors.white), Text('LEADER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])))),
        Positioned(top: 170, left: 100, child: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(8)),
          child: Text('Follower attached', style: TextStyle(fontSize: 11)))),
      ]))),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('LeaderLayer defines a reference point for FollowerLayers', style: TextStyle(fontSize: 11))),
  ])));
}
