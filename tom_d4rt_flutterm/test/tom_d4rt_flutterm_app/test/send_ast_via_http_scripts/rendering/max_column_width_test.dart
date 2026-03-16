import 'package:flutter/material.dart';

/// Deep visual demo for MaxColumnWidth in tables
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MaxColumnWidth')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Maximum Column Width', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Table(columnWidths: {
      0: MaxColumnWidth(FixedColumnWidth(50), FractionColumnWidth(0.3)),
      1: MaxColumnWidth(FixedColumnWidth(100), FractionColumnWidth(0.5)),
    }, border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(children: [
          Container(padding: EdgeInsets.all(16), color: Colors.blue.withOpacity(0.2), child: Text('max(50, 30%)', textAlign: TextAlign.center)),
          Container(padding: EdgeInsets.all(16), color: Colors.orange.withOpacity(0.2), child: Text('max(100, 50%)', textAlign: TextAlign.center)),
        ]),
        TableRow(children: [
          Container(padding: EdgeInsets.all(16), color: Colors.blue.withOpacity(0.1), child: Text('A', textAlign: TextAlign.center)),
          Container(padding: EdgeInsets.all(16), color: Colors.orange.withOpacity(0.1), child: Text('B', textAlign: TextAlign.center)),
        ]),
      ]),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('MaxColumnWidth(a, b):', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Returns max of two widths', style: TextStyle(fontSize: 11)),
        Text('• Ensures minimum space', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
