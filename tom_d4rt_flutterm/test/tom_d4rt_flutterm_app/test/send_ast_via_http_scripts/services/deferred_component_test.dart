import 'package:flutter/material.dart';

/// Deep visual demo for DeferredComponent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Deferred Load')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('DeferredComponent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.download, size: 48, color: Colors.teal),
        SizedBox(height: 12),
        Text('On-Demand Feature Loading', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _Step('1', 'Define split module'),
        Icon(Icons.arrow_downward, size: 20, color: Colors.teal),
        _Step('2', 'Check installState'),
        Icon(Icons.arrow_downward, size: 20, color: Colors.teal),
        _Step('3', 'Call installDeferredComponent'),
        Icon(Icons.arrow_downward, size: 20, color: Colors.teal),
        _Step('4', 'Load and use feature'),
      ])),
  ])));
}

class _Step extends StatelessWidget {
  final String num; final String text;
  const _Step(this.num, this.text);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 2), padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [CircleAvatar(radius: 10, backgroundColor: Colors.teal, child: Text(num, style: TextStyle(color: Colors.white, fontSize: 10))), SizedBox(width: 8), Text(text, style: TextStyle(fontSize: 11))]));
}
