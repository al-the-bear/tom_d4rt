import 'package:flutter/material.dart';

/// Deep visual demo for TextOverflow
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextOverflow Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [Container(width: 200, child: Text('This is a very long text that will clip', overflow: TextOverflow.clip)), SizedBox(height: 20), Container(width: 200, child: Text('This is a very long text with ellipsis...', overflow: TextOverflow.ellipsis)), SizedBox(height: 20), Container(width: 200, child: Text('This is a very long text that will fade', overflow: TextOverflow.fade, softWrap: false)), SizedBox(height: 20), Container(width: 200, child: Text('This is a very long text that can wrap to multiple lines', overflow: TextOverflow.visible))])));
}
