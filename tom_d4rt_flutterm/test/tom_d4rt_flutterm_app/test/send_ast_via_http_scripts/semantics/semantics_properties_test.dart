import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsProperties
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SemanticsProperties')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantics Properties', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _PropSection('Identification', [_Prop('label', 'Screen reader text'), _Prop('value', 'Current value'), _Prop('hint', 'Usage description')]),
      _PropSection('State', [_Prop('enabled', 'Interactive state'), _Prop('checked', 'Toggle state'), _Prop('selected', 'Selection state')]),
      _PropSection('Actions', [_Prop('onTap', 'Tap handler'), _Prop('onLongPress', 'Long press'), _Prop('onScrollLeft/Right', 'Scroll handlers')]),
      _PropSection('Structure', [_Prop('container', 'Group children'), _Prop('explicitChildNodes', 'Child control'), _Prop('sortKey', 'Focus order')]),
    ])),
  ])));
}

class _PropSection extends StatelessWidget {
  final String title; final List<_Prop> props;
  const _PropSection(this.title, this.props);
  @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
    ...props, Divider(),
  ]);
}

class _Prop extends StatelessWidget {
  final String name; final String desc;
  const _Prop(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(width: 8), Expanded(child: Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey)))]));
}
