import 'package:flutter/material.dart';

/// Deep visual demo for Decoration
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Decoration Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [DecoratedBox(decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8)), child: Padding(padding: EdgeInsets.all(16), child: Text('BoxDecoration'))), SizedBox(height: 16), DecoratedBox(decoration: ShapeDecoration(color: Colors.green.shade100, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: Padding(padding: EdgeInsets.all(16), child: Text('ShapeDecoration'))), SizedBox(height: 16), DecoratedBox(decoration: FlutterLogoDecoration(style: FlutterLogoStyle.horizontal), child: SizedBox(width: 200, height: 60)), SizedBox(height: 16), Text('Decoration is the base class', style: TextStyle(color: Colors.grey))])));
}
