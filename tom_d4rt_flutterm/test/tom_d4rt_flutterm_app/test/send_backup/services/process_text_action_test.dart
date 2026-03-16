import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for ProcessTextAction
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ProcessTextAction')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Text Processing Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.text_snippet, size: 48, color: Colors.amber.shade700),
        SizedBox(height: 12),
        Text('ProcessTextAction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        Text('Android ACTION_PROCESS_TEXT', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Common Actions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        SizedBox(height: 8),
        _Action(Icons.translate, 'Translate', 'Convert to another language'),
        _Action(Icons.book, 'Define', 'Dictionary lookup'),
        _Action(Icons.search, 'Search', 'Web search for text'),
        _Action(Icons.share, 'Share', 'Share via other apps'),
      ]))),
    SizedBox(height: 8),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Constructor: ProcessTextAction(id, label)', style: TextStyle(fontFamily: 'monospace', fontSize: 9))),
  ])));
}

class _Action extends StatelessWidget {
  final IconData icon; final String name; final String desc;
  const _Action(this.icon, this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 6),
    child: Row(children: [Icon(icon, size: 18, color: Colors.amber.shade700), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
