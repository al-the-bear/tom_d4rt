import 'package:flutter/material.dart';

/// Deep visual demo for PipelineManifold
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PipelineManifold')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Rendering Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _PipeStep(1, 'Layout', 'Size and position'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _PipeStep(2, 'Paint', 'Draw to canvas'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _PipeStep(3, 'Composite', 'Combine layers'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _PipeStep(4, 'Semantics', 'Accessibility tree'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('PipelineManifold coordinates multiple render pipelines and semantics', style: TextStyle(fontSize: 11))),
  ])));
}

class _PipeStep extends StatelessWidget {
  final int num; final String title; final String desc;
  const _PipeStep(this.num, this.title, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(8),
    child: Row(children: [CircleAvatar(radius: 14, backgroundColor: Colors.purple, child: Text('$num', style: TextStyle(color: Colors.white, fontSize: 12))), SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 11))])]));
}
