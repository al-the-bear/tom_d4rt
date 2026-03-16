import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Deep visual demo for GrowthDirection enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('GrowthDirection')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Growth Direction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 20),
    _DirectionDemo(GrowthDirection.forward, 'Forward', 'Items grow in positive scroll direction', Colors.blue),
    SizedBox(height: 16),
    _DirectionDemo(GrowthDirection.reverse, 'Reverse', 'Items grow in negative scroll direction', Colors.orange),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by slivers to determine which direction to lay out children', style: TextStyle(fontSize: 12))),
  ])));
}

class _DirectionDemo extends StatelessWidget {
  final GrowthDirection dir; final String name; final String desc; final Color color;
  const _DirectionDemo(this.dir, this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
    child: Row(children: [
      Column(children: [
        if (dir == GrowthDirection.forward) Icon(Icons.arrow_downward, color: color, size: 32),
        for (int i = 1; i <= 3; i++) Container(margin: EdgeInsets.symmetric(vertical: 2), width: 40, height: 20, decoration: BoxDecoration(color: color.withOpacity(0.3 + i * 0.2), borderRadius: BorderRadius.circular(4)),
          child: Center(child: Text('$i', style: TextStyle(fontSize: 10)))),
        if (dir == GrowthDirection.reverse) Icon(Icons.arrow_upward, color: color, size: 32),
      ]),
      SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(height: 4), Text(desc, style: TextStyle(fontSize: 12))])),
    ]));
}
