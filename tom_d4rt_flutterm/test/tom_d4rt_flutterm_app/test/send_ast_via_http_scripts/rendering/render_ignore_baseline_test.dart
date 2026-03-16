import 'package:flutter/material.dart';

/// Deep visual demo for RenderIgnoreBaseline
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Ignore Baseline')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Baseline Ignoring', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('With baseline', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('Big', style: TextStyle(fontSize: 32)),
          Text('Small', style: TextStyle(fontSize: 14)),
        ]),
        SizedBox(height: 16),
        Text('With IgnoreBaseline', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
          Text('Big', style: TextStyle(fontSize: 32)),
          Container(color: Colors.amber.shade200, child: Text('Small', style: TextStyle(fontSize: 14))),
        ]),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Prevents child baseline from being used in alignment calculations', style: TextStyle(fontSize: 11))),
  ])));
}
