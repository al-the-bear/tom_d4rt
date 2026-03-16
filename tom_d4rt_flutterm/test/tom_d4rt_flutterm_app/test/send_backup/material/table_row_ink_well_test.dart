import 'package:flutter/material.dart';

/// Deep visual demo for TableRowInkWell
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TableRowInkWell Demo')), body: Padding(padding: EdgeInsets.all(16), child: Table(border: TableBorder.all(color: Colors.grey), children: [TableRow(children: [TableRowInkWell(onTap: () {}, child: Padding(padding: EdgeInsets.all(12), child: Text('Row 1 - Tap me', style: TextStyle(fontWeight: FontWeight.bold)))), Padding(padding: EdgeInsets.all(12), child: Text('Data 1'))]), TableRow(children: [TableRowInkWell(onTap: () {}, child: Padding(padding: EdgeInsets.all(12), child: Text('Row 2 - Tap me'))), Padding(padding: EdgeInsets.all(12), child: Text('Data 2'))]), TableRow(children: [TableRowInkWell(onTap: () {}, onLongPress: () {}, child: Padding(padding: EdgeInsets.all(12), child: Text('Row 3 - Long press'))), Padding(padding: EdgeInsets.all(12), child: Text('Data 3'))])])));
}
