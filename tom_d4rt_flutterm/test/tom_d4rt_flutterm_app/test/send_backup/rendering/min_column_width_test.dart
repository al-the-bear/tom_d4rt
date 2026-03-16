import 'package:flutter/material.dart';

/// Deep visual demo for MinColumnWidth in tables
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MinColumnWidth')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Minimum Column Width', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Table(columnWidths: {
      0: MinColumnWidth(FixedColumnWidth(200), FractionColumnWidth(0.3)),
      1: MinColumnWidth(FixedColumnWidth(200), FractionColumnWidth(0.5)),
    }, border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(children: [
          Container(padding: EdgeInsets.all(16), color: Colors.green.withOpacity(0.2), child: Text('min(200, 30%)', textAlign: TextAlign.center)),
          Container(padding: EdgeInsets.all(16), color: Colors.purple.withOpacity(0.2), child: Text('min(200, 50%)', textAlign: TextAlign.center)),
        ]),
        TableRow(children: [
          Container(padding: EdgeInsets.all(16), color: Colors.green.withOpacity(0.1), child: Text('A', textAlign: TextAlign.center)),
          Container(padding: EdgeInsets.all(16), color: Colors.purple.withOpacity(0.1), child: Text('B', textAlign: TextAlign.center)),
        ]),
      ]),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('MinColumnWidth(a, b):', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Returns smaller of two widths', style: TextStyle(fontSize: 11)),
        Text('• Caps maximum space', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
