import 'package:flutter/material.dart';

/// Deep visual demo for DirectionalFocusTraversalPolicyMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Focus Traversal Policy')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Directional Focus Traversal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.arrow_upward, color: Colors.blue), SizedBox(width: 16),
          Icon(Icons.arrow_back, color: Colors.blue), Icon(Icons.radio_button_checked, color: Colors.blue.shade700), Icon(Icons.arrow_forward, color: Colors.blue),
          SizedBox(width: 16), Icon(Icons.arrow_downward, color: Colors.blue),
        ]),
        SizedBox(height: 12),
        Text('Mixin for Focus Direction', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _Method('findFirstFocusInDirection', 'Find first focusable'),
        _Method('inDirection', 'Navigate in direction'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Arrow key navigation for focus management', style: TextStyle(fontSize: 10))),
  ])));
}
class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
