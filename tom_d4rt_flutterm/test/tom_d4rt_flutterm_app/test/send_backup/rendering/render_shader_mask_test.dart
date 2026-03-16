import 'package:flutter/material.dart';

/// Deep visual demo for RenderShaderMask
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ShaderMask')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Gradient Shader Mask', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    ShaderMask(blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(colors: [Colors.blue, Colors.red]).createShader(bounds),
      child: Container(width: 200, height: 100, child: Center(child: Text('GRADIENT', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))))),
    SizedBox(height: 24),
    ShaderMask(blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => RadialGradient(colors: [Colors.yellow, Colors.orange, Colors.red]).createShader(bounds),
      child: Icon(Icons.star, size: 100)),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Applies a shader gradient to child during compositing', style: TextStyle(fontSize: 11))),
  ])));
}
