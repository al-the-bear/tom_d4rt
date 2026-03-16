import 'package:flutter/material.dart';

/// Deep visual demo for RenderObjectWithLayoutCallbackMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('LayoutCallback')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layout Callback Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _Step('1', 'Parent starts layout'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _Step('2', 'Callback invokes builder'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _Step('3', 'Builder uses constraints'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _Step('4', 'Child tree created'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by LayoutBuilder to provide parent constraints to builder', style: TextStyle(fontSize: 11))),
  ])));
}

class _Step extends StatelessWidget {
  final String num; final String text;
  const _Step(this.num, this.text);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [CircleAvatar(radius: 12, backgroundColor: Colors.purple, child: Text(num, style: TextStyle(color: Colors.white, fontSize: 11))), SizedBox(width: 8), Text(text, style: TextStyle(fontWeight: FontWeight.bold))]));
}
