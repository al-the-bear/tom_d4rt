import 'package:flutter/material.dart';

/// Deep visual demo for FlutterLogoStyle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FlutterLogoStyle Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [Column(children: [FlutterLogo(size: 60, style: FlutterLogoStyle.markOnly), Text('markOnly', style: TextStyle(fontSize: 11))]), SizedBox(width: 30), Column(children: [FlutterLogo(size: 60, style: FlutterLogoStyle.horizontal), Text('horizontal', style: TextStyle(fontSize: 11))]), SizedBox(width: 30), Column(children: [FlutterLogo(size: 60, style: FlutterLogoStyle.stacked), Text('stacked', style: TextStyle(fontSize: 11))])])])));
}
