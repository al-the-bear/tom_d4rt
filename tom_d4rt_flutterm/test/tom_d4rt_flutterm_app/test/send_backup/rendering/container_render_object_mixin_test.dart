import 'package:flutter/material.dart';

/// Deep visual demo for ContainerRenderObjectMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ContainerRenderObjectMixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Multi-Child Render Mixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _Parent(),
        SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _Op('insert'),
          _Op('move'),
          _Op('remove'),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Key Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• childCount: int', style: TextStyle(fontSize: 11)),
        Text('• firstChild / lastChild', style: TextStyle(fontSize: 11)),
        SizedBox(height: 8),
        Text('Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• insert(child)', style: TextStyle(fontSize: 11)),
        Text('• remove(child)', style: TextStyle(fontSize: 11)),
        Text('• move(child, after)', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _Parent extends StatelessWidget {
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      for (int i = 1; i <= 4; i++) Container(margin: EdgeInsets.symmetric(horizontal: 4), width: 40, height: 40, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Center(child: Text('$i', style: TextStyle(fontWeight: FontWeight.bold)))),
    ]));
}

class _Op extends StatelessWidget {
  final String name;
  const _Op(this.name);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.teal.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
    child: Text(name, style: TextStyle(fontSize: 10)));
}
