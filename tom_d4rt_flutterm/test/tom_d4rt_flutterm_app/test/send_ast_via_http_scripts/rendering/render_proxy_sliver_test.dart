import 'package:flutter/material.dart';

/// Deep visual demo for RenderProxySliver
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ProxySliver')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Proxy Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(padding: EdgeInsets.all(12), width: double.infinity, decoration: BoxDecoration(color: Colors.teal.shade200, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('Parent Sliver', style: TextStyle(fontWeight: FontWeight.bold)))),
        Icon(Icons.arrow_downward, color: Colors.teal),
        Container(padding: EdgeInsets.all(12), width: double.infinity, decoration: BoxDecoration(color: Colors.teal.shade300, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('RenderProxySliver', style: TextStyle(fontWeight: FontWeight.bold)))),
        Icon(Icons.arrow_downward, color: Colors.teal),
        Container(padding: EdgeInsets.all(12), width: double.infinity, decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('Child Sliver', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Like ProxyBox but for sliver geometry delegation', style: TextStyle(fontSize: 11))),
  ])));
}
