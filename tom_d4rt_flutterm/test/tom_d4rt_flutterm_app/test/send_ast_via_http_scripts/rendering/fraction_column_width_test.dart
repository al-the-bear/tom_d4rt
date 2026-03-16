import 'package:flutter/material.dart';

/// Deep visual demo for FractionColumnWidth in tables
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FractionColumnWidth')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Table Column Widths', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Table(columnWidths: {
      0: FractionColumnWidth(0.3),
      1: FractionColumnWidth(0.5),
      2: FractionColumnWidth(0.2),
    }, border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(children: [_Cell('30%', Colors.blue), _Cell('50%', Colors.orange), _Cell('20%', Colors.green)]),
        TableRow(children: [_Cell('A', Colors.blue.shade100), _Cell('B', Colors.orange.shade100), _Cell('C', Colors.green.shade100)]),
      ]),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('FractionColumnWidth(fraction):', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• fraction: 0.0 to 1.0', style: TextStyle(fontSize: 11)),
        Text('• Percentage of table width', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _Cell extends StatelessWidget {
  final String text; final Color color;
  const _Cell(this.text, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), color: color.withOpacity(0.3), child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold))));
}
