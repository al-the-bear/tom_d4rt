import 'package:flutter/material.dart';

/// Deep visual demo for LeaderLayer (followed by FollowerLayer)
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('LeaderLayer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Leader-Follower Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.location_on, color: Colors.white), SizedBox(width: 8), Text('Leader', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])),
        Container(margin: EdgeInsets.only(top: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
          child: Text('Follower tracks this', style: TextStyle(color: Colors.white, fontSize: 12))),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('LeaderLayer establishes:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Position reference point', style: TextStyle(fontSize: 11)),
        Text('• Connected via LayerLink', style: TextStyle(fontSize: 11)),
        Text('• FollowerLayer positions relative to it', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
