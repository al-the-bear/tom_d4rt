import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for RenderAnnotatedRegion
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Annotated Region')), body: Column(children: [
    AnnotatedRegion<SystemUiOverlayStyle>(value: SystemUiOverlayStyle.dark,
      child: Container(height: 150, color: Colors.white, child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.light_mode, size: 48, color: Colors.amber),
        Text('Light Area', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Dark status bar icons', style: TextStyle(fontSize: 11)),
      ])))),
    AnnotatedRegion<SystemUiOverlayStyle>(value: SystemUiOverlayStyle.light,
      child: Container(height: 150, color: Colors.grey.shade900, child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.dark_mode, size: 48, color: Colors.white),
        Text('Dark Area', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        Text('Light status bar icons', style: TextStyle(fontSize: 11, color: Colors.white70)),
      ])))),
    Padding(padding: EdgeInsets.all(16), child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('AnnotatedRegion attaches metadata (like SystemUiOverlayStyle) to regions', style: TextStyle(fontSize: 11)))),
  ]));
}
