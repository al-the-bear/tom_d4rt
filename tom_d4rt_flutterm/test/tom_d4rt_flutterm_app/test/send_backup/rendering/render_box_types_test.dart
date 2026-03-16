import 'package:flutter/material.dart';

/// Deep visual demo for RenderBox types
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('RenderBox Types')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Common RenderBox Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _BoxCard('RenderConstrainedBox', 'Min/max constraints', Colors.blue),
      _BoxCard('RenderLimitedBox', 'Limited size', Colors.green),
      _BoxCard('RenderAspectRatio', 'Fixed ratio', Colors.orange),
      _BoxCard('RenderIntrinsicHeight', 'Intrinsic sizing', Colors.purple),
      _BoxCard('RenderSizedBox', 'Fixed size', Colors.red),
    ])),
  ])));
}

class _BoxCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _BoxCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.crop_square, color: color), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'monospace')), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
