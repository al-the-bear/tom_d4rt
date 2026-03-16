import 'package:flutter/material.dart';

/// Deep visual demo for StackFit enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Stack Fit')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('StackFit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _FitCard('loose', 'Children can be smaller', Colors.blue),
    _FitCard('expand', 'Children fill the stack', Colors.green),
    _FitCard('passthrough', 'Pass parent constraints', Colors.orange),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Controls how non-positioned children are sized', style: TextStyle(fontSize: 11))),
  ])));
}

class _FitCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _FitCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Container(width: 60, height: 60, decoration: BoxDecoration(border: Border.all(color: color, width: 2), borderRadius: BorderRadius.circular(4)),
        child: Center(child: Container(width: name == 'loose' ? 30 : 54, height: name == 'loose' ? 30 : 54, decoration: BoxDecoration(color: color.shade200, borderRadius: BorderRadius.circular(2))))),
      SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 14)), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))])),
    ]));
}
