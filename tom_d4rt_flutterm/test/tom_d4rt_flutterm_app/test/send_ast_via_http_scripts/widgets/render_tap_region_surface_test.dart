import 'package:flutter/material.dart';

/// Deep visual demo for RenderTapRegionSurface
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TapRegionSurface')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Tap Region Surface', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.touch_app, size: 48, color: Colors.red),
        SizedBox(height: 12),
        Text('RenderTapRegionSurface', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 8),
        Text('Surface for coordinated tap regions', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        SizedBox(height: 4),
        _Property('groupId', 'Object?'),
        _Property('behavior', 'HitTestBehavior'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Manages tap outside detection for menus & dropdowns', style: TextStyle(fontSize: 10))),
  ])));
}
class _Property extends StatelessWidget {
  final String name; final String type;
  const _Property(this.name, this.type);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(type, style: TextStyle(fontSize: 9, color: Colors.red))]));
}
