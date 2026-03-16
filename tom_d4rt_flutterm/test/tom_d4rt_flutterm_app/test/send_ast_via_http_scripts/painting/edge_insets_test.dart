import 'package:flutter/material.dart';

/// Deep visual demo for EdgeInsets
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('EdgeInsets Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [Container(color: Colors.blue.shade100, child: Padding(padding: EdgeInsets.all(16), child: Text('EdgeInsets.all(16)'))), SizedBox(height: 16), Container(color: Colors.green.shade100, child: Padding(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8), child: Text('EdgeInsets.symmetric'))), SizedBox(height: 16), Container(color: Colors.orange.shade100, child: Padding(padding: EdgeInsets.only(left: 40, top: 8), child: Text('EdgeInsets.only'))), SizedBox(height: 16), Container(color: Colors.purple.shade100, child: Padding(padding: EdgeInsets.fromLTRB(8, 16, 24, 32), child: Text('EdgeInsets.fromLTRB')))])));
}
