import 'package:flutter/material.dart';

/// Deep visual demo for FlutterLogoDecoration
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FlutterLogoDecoration Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 200, height: 80, decoration: FlutterLogoDecoration(style: FlutterLogoStyle.horizontal)), SizedBox(height: 20), Container(width: 100, height: 100, decoration: FlutterLogoDecoration(style: FlutterLogoStyle.markOnly)), SizedBox(height: 20), Container(width: 200, height: 80, decoration: FlutterLogoDecoration(style: FlutterLogoStyle.stacked))])));
}
