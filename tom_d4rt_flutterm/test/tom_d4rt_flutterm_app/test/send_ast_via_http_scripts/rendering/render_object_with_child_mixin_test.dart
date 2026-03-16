import 'package:flutter/material.dart';

/// Deep visual demo for RenderObjectWithChildMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('WithChildMixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Single Child Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _MixinBox('Parent RenderObject', Colors.deepOrange, true),
        Container(margin: EdgeInsets.symmetric(vertical: 8), child: Icon(Icons.arrow_downward, color: Colors.deepOrange)),
        _MixinBox('Single Child', Colors.orange, false),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Provides:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• child getter/setter', style: TextStyle(fontSize: 11)),
        Text('• attach/detach handling', style: TextStyle(fontSize: 11)),
        Text('• visitChildren implementation', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _MixinBox extends StatelessWidget {
  final String label; final Color color; final bool isParent;
  const _MixinBox(this.label, this.color, this.isParent);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(isParent ? Icons.account_tree : Icons.crop_square, color: Colors.white), SizedBox(width: 8), Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]));
}
