import 'package:flutter/material.dart';

/// Deep visual demo for VerticalDirection
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('VerticalDirection Demo')), body: Row(children: [Expanded(child: Column(verticalDirection: VerticalDirection.down, children: [Container(height: 50, color: Colors.red.shade100, child: Center(child: Text('1'))), Container(height: 50, color: Colors.red.shade200, child: Center(child: Text('2'))), Container(height: 50, color: Colors.red.shade300, child: Center(child: Text('3'))), Text('down', style: TextStyle(fontWeight: FontWeight.bold))])), Expanded(child: Column(verticalDirection: VerticalDirection.up, children: [Container(height: 50, color: Colors.blue.shade100, child: Center(child: Text('1'))), Container(height: 50, color: Colors.blue.shade200, child: Center(child: Text('2'))), Container(height: 50, color: Colors.blue.shade300, child: Center(child: Text('3'))), Text('up', style: TextStyle(fontWeight: FontWeight.bold))]))]));
}
