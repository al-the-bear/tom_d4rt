import 'package:flutter/material.dart';

/// Deep visual demo for ToggleableStateMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ToggleableStateMixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Toggleable State Mixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lightBlue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.toggle_off, size: 40, color: Colors.grey),
          SizedBox(width: 16),
          Icon(Icons.toggle_on, size: 40, color: Colors.lightBlue),
        ]),
        SizedBox(height: 12),
        Text('State for Toggleables', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Mixin for checkbox, radio, switch', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Property('isInteractive', 'bool'),
        _Property('value', 'bool?'),
        _Property('tristate', 'bool'),
        _Property('positionController', 'AnimationController'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Provides animation & interaction handling', style: TextStyle(fontSize: 10))),
  ])));
}
class _Property extends StatelessWidget {
  final String name; final String type;
  const _Property(this.name, this.type);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(type, style: TextStyle(color: Colors.lightBlue, fontSize: 9))]));
}
