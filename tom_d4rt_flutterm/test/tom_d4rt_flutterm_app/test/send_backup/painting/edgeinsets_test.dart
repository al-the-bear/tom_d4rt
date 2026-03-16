import 'package:flutter/material.dart';

/// Deep visual demo for EdgeInsetsGeometry
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('EdgeInsetsGeometry Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 2)), child: Container(padding: EdgeInsetsDirectional.only(start: 20), decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 2)), child: Text('Nested padding'))), SizedBox(height: 20), Text('EdgeInsets vs EdgeInsetsDirectional', style: TextStyle(fontWeight: FontWeight.bold)), Text('Directional respects text direction', style: TextStyle(color: Colors.grey, fontSize: 12))])));
}
