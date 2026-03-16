import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsEvent base class
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SemanticsEvent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Base Semantics Event', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: Text('SemanticsEvent', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        SizedBox(height: 12),
        Text('Abstract base class for events', style: TextStyle(fontSize: 12)),
        SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.arrow_downward, color: Colors.blue),
        ]),
        SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
          _SubClass('Tap'),
          _SubClass('LongPress'),
          _SubClass('Focus'),
          _SubClass('Announce'),
          _SubClass('Tooltip'),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Key Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• type: String identifier', style: TextStyle(fontSize: 11)),
        Text('• toMap(): Serialization', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _SubClass extends StatelessWidget {
  final String name;
  const _SubClass(this.name);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.blue)), child: Text(name, style: TextStyle(fontSize: 10)));
}
