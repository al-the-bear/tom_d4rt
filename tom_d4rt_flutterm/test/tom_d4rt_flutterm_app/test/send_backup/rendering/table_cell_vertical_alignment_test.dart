import 'package:flutter/material.dart';

/// Deep visual demo for TableCellVerticalAlignment enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Cell Alignment')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TableCellVerticalAlignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _AlignCard('top', 'Align to top', Alignment.topCenter),
      _AlignCard('middle', 'Center vertically', Alignment.center),
      _AlignCard('bottom', 'Align to bottom', Alignment.bottomCenter),
      _AlignCard('baseline', 'Align text baselines', Alignment.center),
      _AlignCard('fill', 'Expand to fill', Alignment.center),
      _AlignCard('intrinsicHeight', 'Use intrinsic height', Alignment.center),
    ])),
  ])));
}

class _AlignCard extends StatelessWidget {
  final String name; final String desc; final Alignment align;
  const _AlignCard(this.name, this.desc, this.align);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Container(width: 50, height: 50, decoration: BoxDecoration(border: Border.all(color: Colors.indigo), borderRadius: BorderRadius.circular(4)),
        child: Align(alignment: align, child: Container(width: 30, height: 15, color: Colors.indigo.shade200))),
      SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))])),
    ]));
}
