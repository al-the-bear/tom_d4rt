import 'package:flutter/material.dart';

/// Deep visual demo for viewport base
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Viewport Base')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('RenderViewportBase', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _Prop('axisDirection', 'AxisDirection.down'),
        _Prop('crossAxisDirection', 'AxisDirection.right'),
        _Prop('offset', 'ViewportOffset'),
        _Prop('cacheExtent', '250.0 (default)'),
        _Prop('cacheExtentStyle', 'CacheExtentStyle.pixel'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Base class for Viewport and ShrinkWrappingViewport', style: TextStyle(fontSize: 11))),
  ])));
}

class _Prop extends StatelessWidget {
  final String name; final String val;
  const _Prop(this.name, this.val);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(val, style: TextStyle(fontSize: 10, color: Colors.indigo))]));
}
