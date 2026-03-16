import 'package:flutter/material.dart';

/// Deep visual demo for WrapAlignment enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Wrap Alignment')), body: Padding(padding: EdgeInsets.all(8), child: Column(children: [
    Text('WrapAlignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 8),
    _AlignDemo('start', WrapAlignment.start, Colors.blue),
    _AlignDemo('end', WrapAlignment.end, Colors.green),
    _AlignDemo('center', WrapAlignment.center, Colors.orange),
    _AlignDemo('spaceBetween', WrapAlignment.spaceBetween, Colors.purple),
    _AlignDemo('spaceAround', WrapAlignment.spaceAround, Colors.red),
    _AlignDemo('spaceEvenly', WrapAlignment.spaceEvenly, Colors.teal),
  ])));
}

class _AlignDemo extends StatelessWidget {
  final String name; final WrapAlignment align; final MaterialColor color;
  const _AlignDemo(this.name, this.align, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(4), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [
      SizedBox(width: 80, child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 9))),
      Expanded(child: Container(height: 24, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
        child: Wrap(alignment: align, children: [for (var i = 0; i < 3; i++) Container(width: 30, height: 20, margin: EdgeInsets.all(1), color: color.shade200)]))),
    ]));
}
