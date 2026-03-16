import 'package:flutter/material.dart';

/// Deep visual demo for TreeSliverNodeParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Node Parent Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TreeSliverNodeParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.brown.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.account_tree, size: 48, color: Colors.brown),
        SizedBox(height: 12),
        Text('Tree Node Layout Data', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _Field('depth', 'int - Nesting level'),
        _Field('isExpanded', 'bool - Show children'),
        _Field('parent', 'TreeSliverNode - Parent ref'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Stores tree structure info for rendering', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
