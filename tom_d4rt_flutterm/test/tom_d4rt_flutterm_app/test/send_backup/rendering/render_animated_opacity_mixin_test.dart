import 'package:flutter/material.dart';

/// Deep visual demo for RenderAnimatedOpacityMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AnimatedOpacity Mixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Animated Opacity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: TweenAnimationBuilder<double>(tween: Tween(begin: 0.2, end: 1.0), duration: Duration(seconds: 2),
      builder: (_, opacity, __) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Opacity(opacity: opacity, child: Container(width: 150, height: 150, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(16)),
          child: Center(child: Icon(Icons.visibility, color: Colors.white, size: 60)))),
        SizedBox(height: 16),
        Text('Opacity: ${(opacity * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold)),
      ]))),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Mixin provides:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Efficient opacity animation', style: TextStyle(fontSize: 11)),
        Text('• Skips paint when fully transparent', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
