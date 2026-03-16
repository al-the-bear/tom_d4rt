import 'package:flutter/material.dart';

/// Deep visual demo for sizing render objects
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sizing RenderObjects')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Size Constraints', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _SizingDemo('ConstrainedBox', ConstrainedBox(constraints: BoxConstraints(minWidth: 100, maxWidth: 200), child: Container(color: Colors.blue, height: 40, child: Center(child: Text('100-200w', style: TextStyle(color: Colors.white)))))),
      _SizingDemo('SizedBox', SizedBox(width: 100, height: 50, child: Container(color: Colors.green, child: Center(child: Text('100x50', style: TextStyle(color: Colors.white)))))),
      _SizingDemo('LimitedBox', LimitedBox(maxWidth: 150, maxHeight: 60, child: Container(color: Colors.orange, child: Center(child: Text('max 150x60', style: TextStyle(color: Colors.white)))))),
      _SizingDemo('FractionallySizedBox', FractionallySizedBox(widthFactor: 0.6, child: Container(color: Colors.purple, height: 40, child: Center(child: Text('60% width', style: TextStyle(color: Colors.white)))))),
    ])),
  ])));
}

class _SizingDemo extends StatelessWidget {
  final String label; final Widget child;
  const _SizingDemo(this.label, this.child);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), SizedBox(height: 8), child]));
}
