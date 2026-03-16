import 'package:flutter/material.dart';

/// Deep visual demo for TableCellParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Cell Parent Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TableCellParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Table(border: TableBorder.all(color: Colors.teal),
          children: [
            TableRow(children: [
              TableCell(verticalAlignment: TableCellVerticalAlignment.top, child: Container(height: 60, color: Colors.teal.shade100, child: Text('top', style: TextStyle(fontSize: 10)))),
              TableCell(verticalAlignment: TableCellVerticalAlignment.middle, child: Container(height: 60, color: Colors.teal.shade200, child: Center(child: Text('middle', style: TextStyle(fontSize: 10))))),
              TableCell(verticalAlignment: TableCellVerticalAlignment.bottom, child: Container(height: 60, color: Colors.teal.shade300, child: Align(alignment: Alignment.bottomCenter, child: Text('bottom', style: TextStyle(fontSize: 10))))),
            ]),
          ]),
        SizedBox(height: 12),
        _Field('verticalAlignment', 'TableCellVerticalAlignment'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Per-cell alignment override', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
