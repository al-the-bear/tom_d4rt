import 'package:flutter/material.dart';

/// Deep visual demo for keep alive mixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Keep Alive')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Keep Alive Mixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.save, size: 48, color: Colors.deepOrange),
        SizedBox(height: 12),
        Text('AutomaticKeepAliveClientMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 8),
        Text('Keeps widget alive when scrolled off-screen', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Text('wantKeepAlive => true', style: TextStyle(fontFamily: 'monospace', fontSize: 11))),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Preserves state for list items like text fields', style: TextStyle(fontSize: 11))),
  ])));
}
