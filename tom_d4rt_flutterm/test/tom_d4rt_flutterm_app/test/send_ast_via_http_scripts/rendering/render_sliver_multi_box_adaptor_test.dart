import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverMultiBoxAdaptor
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Multi Box Adaptor')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Multi Box Sliver Adaptor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _Step('1', 'Manager creates children on demand'),
        Icon(Icons.arrow_downward, color: Colors.teal),
        _Step('2', 'Adaptor positions children'),
        Icon(Icons.arrow_downward, color: Colors.teal),
        _Step('3', 'Off-screen children recycled'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Base for SliverList and SliverGrid', style: TextStyle(fontSize: 11))),
  ])));
}

class _Step extends StatelessWidget {
  final String num; final String text;
  const _Step(this.num, this.text);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [CircleAvatar(radius: 12, backgroundColor: Colors.teal, child: Text(num, style: TextStyle(color: Colors.white, fontSize: 11))), SizedBox(width: 8), Text(text, style: TextStyle(fontWeight: FontWeight.bold))]));
}
