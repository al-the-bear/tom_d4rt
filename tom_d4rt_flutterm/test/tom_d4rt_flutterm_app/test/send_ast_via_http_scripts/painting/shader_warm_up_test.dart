import 'package:flutter/material.dart';

/// Deep visual demo for ShaderWarmUp
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ShaderWarmUp Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.whatshot, size: 48, color: Colors.deepOrange), SizedBox(height: 16), Text('ShaderWarmUp', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Pre-compiles shaders'), Text('Reduces first-frame jank'), Text('Override warmUpOnCanvas()')]))])));
}
