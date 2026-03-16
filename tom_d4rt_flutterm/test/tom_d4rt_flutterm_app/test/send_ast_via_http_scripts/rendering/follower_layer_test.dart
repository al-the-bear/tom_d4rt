import 'package:flutter/material.dart';

/// Deep visual demo for FollowerLayer (follows a LeaderLayer)
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FollowerLayer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Following', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CompositedTransformTarget(link: LayerLink(),
      child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
        child: Stack(children: [
          Positioned(top: 50, left: 50, child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Row(children: [Icon(Icons.location_on, color: Colors.white), Text('Leader', style: TextStyle(color: Colors.white))]))),
          Positioned(top: 100, left: 100, child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
            child: Row(children: [Icon(Icons.link, color: Colors.white, size: 16), Text('Follower', style: TextStyle(color: Colors.white, fontSize: 12))]))),
        ])))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Used for:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Dropdown menus', style: TextStyle(fontSize: 11)),
        Text('• Tooltips', style: TextStyle(fontSize: 11)),
        Text('• Overlays that track widgets', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
