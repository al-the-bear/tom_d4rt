import 'package:flutter/material.dart';

/// Deep visual demo for layout Constraints base class
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Constraints')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layout Constraints', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: Text('Constraints', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _SubType('BoxConstraints', Colors.green),
          _SubType('SliverConstraints', Colors.orange),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Abstract interface for:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• isTight: bool - exact size required', style: TextStyle(fontSize: 11)),
        Text('• isNormalized: bool - valid constraints', style: TextStyle(fontSize: 11)),
        Text('Parent passes constraints DOWN', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
  ])));
}

class _SubType extends StatelessWidget {
  final String name; final Color color;
  const _SubType(this.name, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)));
}
