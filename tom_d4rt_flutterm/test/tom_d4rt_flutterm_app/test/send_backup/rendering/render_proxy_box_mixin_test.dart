import 'package:flutter/material.dart';

/// Deep visual demo for RenderProxyBoxMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ProxyBox Mixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Proxy Box Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade200, borderRadius: BorderRadius.circular(8)),
          child: Text('ProxyBox', style: TextStyle(fontWeight: FontWeight.bold))),
        Container(margin: EdgeInsets.symmetric(vertical: 8), child: Text('delegates to', style: TextStyle(fontSize: 11, color: Colors.grey))),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
          child: Text('child', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Delegates:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• size = child.size', style: TextStyle(fontSize: 11)),
        Text('• hitTest = child.hitTest', style: TextStyle(fontSize: 11)),
        Text('• paint = child.paint', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
