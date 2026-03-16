import 'package:flutter/material.dart';

/// Deep visual demo for view render objects
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('View RenderObjects')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('View Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _ViewStep('RenderView', 'Root of render tree'),
        Icon(Icons.arrow_downward, color: Colors.cyan),
        _ViewStep('Window', 'Platform window'),
        Icon(Icons.arrow_downward, color: Colors.cyan),
        _ViewStep('Scene', 'Composited scene'),
        Icon(Icons.arrow_downward, color: Colors.cyan),
        _ViewStep('Display', 'Physical screen'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('RenderView connects render tree to the window', style: TextStyle(fontSize: 11))),
  ])));
}

class _ViewStep extends StatelessWidget {
  final String name; final String desc;
  const _ViewStep(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.tv, color: Colors.cyan, size: 20), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
