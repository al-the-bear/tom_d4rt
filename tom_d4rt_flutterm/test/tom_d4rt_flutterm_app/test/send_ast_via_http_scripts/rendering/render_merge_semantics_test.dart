import 'package:flutter/material.dart';

/// Deep visual demo for RenderMergeSemantics
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MergeSemantics')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantics Merging', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Row(children: [
      Expanded(child: _SemanticCard('Separate', false, Colors.orange)),
      SizedBox(width: 8),
      Expanded(child: _SemanticCard('Merged', true, Colors.green)),
    ]),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Combines multiple semantic nodes into one for screen readers', style: TextStyle(fontSize: 11))),
  ])));
}

class _SemanticCard extends StatelessWidget {
  final String label; final bool merged; final MaterialColor color;
  const _SemanticCard(this.label, this.merged, this.color);
  @override Widget build(BuildContext context) {
    Widget content = Container(height: 200, padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
      child: Column(children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        Divider(),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)), child: Icon(Icons.image, color: color)),
        SizedBox(height: 4),
        Text('Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text('Description', style: TextStyle(fontSize: 10)),
      ]));
    return merged ? MergeSemantics(child: content) : content;
  }
}
