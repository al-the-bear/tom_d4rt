import 'package:flutter/material.dart';

/// Deep visual demo for sliver paint order types
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Paint Order')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Paint Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _OrderCard('firstIsTop', 'First child painted on top', Colors.blue, [2, 1, 0]),
    _OrderCard('lastIsTop', 'Last child painted on top', Colors.green, [0, 1, 2]),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Controls z-ordering of sliver children', style: TextStyle(fontSize: 11))),
  ])));
}

class _OrderCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final List<int> order;
  const _OrderCard(this.name, this.desc, this.color, this.order);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Container(width: 80, height: 60,
        child: Stack(children: [
          for (var i = 0; i < 3; i++)
            Positioned(left: order[i] * 10.0, top: order[i] * 10.0, child: Container(width: 40, height: 25, decoration: BoxDecoration(color: color.shade100.withAlpha((255 - i * 60).toInt()), border: Border.all(color: color), borderRadius: BorderRadius.circular(4)), child: Center(child: Text('${i + 1}', style: TextStyle(fontSize: 10))))),
        ])),
      SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))])),
    ]));
}
