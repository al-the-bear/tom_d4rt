import 'package:flutter/material.dart';

/// Deep visual demo for ShaderMaskLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Shader Mask Layer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ShaderMaskLayer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ShaderMask(shaderCallback: (bounds) => LinearGradient(colors: [Colors.purple, Colors.blue, Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: Container(decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(12)),
        child: ListView(padding: EdgeInsets.all(16), children: [
          for (var i = 0; i < 10; i++) Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Text('Item ${i + 1}', style: TextStyle(fontWeight: FontWeight.bold))),
        ])))),
    SizedBox(height: 8),
    Text('Gradient fade using shader mask', style: TextStyle(fontSize: 11, color: Colors.grey)),
  ])));
}
