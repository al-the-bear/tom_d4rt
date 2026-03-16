import 'package:flutter/material.dart';

/// Deep visual demo for RenderFollowerLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Follower Layer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Following', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Positioned(top: 60, left: 60, child: Container(width: 100, height: 60, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.location_on, color: Colors.white), Text('Leader', style: TextStyle(color: Colors.white))])))),
        Positioned(top: 130, left: 80, child: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
          child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.link, color: Colors.white, size: 16), Text('Follows leader', style: TextStyle(color: Colors.white, fontSize: 12))]))),
      ]))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('CompositedTransformFollower renders relative to a leader', style: TextStyle(fontSize: 11))),
  ])));
}
