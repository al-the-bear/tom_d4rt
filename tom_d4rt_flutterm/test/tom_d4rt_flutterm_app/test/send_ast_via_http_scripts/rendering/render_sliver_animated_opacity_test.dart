import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverAnimatedOpacity
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Opacity')), body: _SliverOpacityDemo());
}

class _SliverOpacityDemo extends StatefulWidget {
  @override State<_SliverOpacityDemo> createState() => _SliverOpacityDemoState();
}

class _SliverOpacityDemoState extends State<_SliverOpacityDemo> {
  double _opacity = 1.0;
  @override Widget build(BuildContext context) => Column(children: [
    Slider(value: _opacity, onChanged: (v) => setState(() => _opacity = v)),
    Text('Opacity: ${_opacity.toStringAsFixed(2)}'),
    Expanded(child: CustomScrollView(slivers: [
      SliverOpacity(opacity: _opacity, sliver: SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.lime.shade100, borderRadius: BorderRadius.circular(8)),
        child: Text('Sliver item ${i + 1}')), childCount: 10))),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Text('SliverOpacity animates opacity of sliver children', style: TextStyle(fontSize: 11))),
  ]);
}
