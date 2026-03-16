import 'package:flutter/material.dart';

/// Deep visual demo for TableBorder
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Table Border')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TableBorder', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Table(border: TableBorder.all(color: Colors.blue, width: 2),
      children: [
        TableRow(children: [_Cell('A1'), _Cell('B1'), _Cell('C1')]),
        TableRow(children: [_Cell('A2'), _Cell('B2'), _Cell('C2')]),
        TableRow(children: [_Cell('A3'), _Cell('B3'), _Cell('C3')]),
      ]),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        SizedBox(height: 4),
        Text('• top, right, bottom, left', style: TextStyle(fontSize: 10)),
        Text('• horizontalInside, verticalInside', style: TextStyle(fontSize: 10)),
        Text('• borderRadius', style: TextStyle(fontSize: 10)),
      ]))),
  ])));
}

class _Cell extends StatelessWidget {
  final String text;
  const _Cell(this.text);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold))));
}
