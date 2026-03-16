import 'package:flutter/material.dart';

/// Deep visual demo for RenderRotatedBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('RotatedBox')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Quarter Turn Rotation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      for (int q = 0; q < 4; q++) Column(mainAxisSize: MainAxisSize.min, children: [
        RotatedBox(quarterTurns: q, child: Container(width: 60, height: 40, decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(4)),
          child: Center(child: Text('Text', style: TextStyle(color: Colors.white, fontSize: 12))))),
        SizedBox(height: 8),
        Text('$q turns', style: TextStyle(fontSize: 10)),
        Text('${q * 90}°', style: TextStyle(fontSize: 10, color: Colors.grey)),
      ]),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('quarterTurns: 0-3 (90° increments), affects layout', style: TextStyle(fontSize: 11))),
  ])));
}
