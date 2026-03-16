import 'package:flutter/material.dart';

/// Deep visual demo for OverflowBoxFit
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('OverflowBoxFit')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Overflow Box Fitting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _FitDemo('deferToChild', Colors.blue),
      _FitDemo('max', Colors.green),
    ])),
  ])));
}

class _FitDemo extends StatelessWidget {
  final String label; final MaterialColor color;
  const _FitDemo(this.label, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('fit: OverflowBoxFit.$label', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')), SizedBox(height: 8), Container(width: 100, height: 60, color: color, child: Center(child: Text(label, style: TextStyle(color: Colors.white))))]));
}
