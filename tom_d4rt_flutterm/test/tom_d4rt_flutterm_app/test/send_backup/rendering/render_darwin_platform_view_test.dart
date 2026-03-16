import 'package:flutter/material.dart';

/// Deep visual demo for RenderDarwinPlatformView
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Darwin Platform View')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('iOS/macOS Native Views', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _PlatformCard('UIView (iOS)', 'iOS native view', Colors.blue),
      _PlatformCard('NSView (macOS)', 'macOS native view', Colors.purple),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Embeds native Apple platform views in Flutter', style: TextStyle(fontSize: 11))),
  ])));
}

class _PlatformCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _PlatformCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Row(children: [Icon(Icons.apple, color: color, size: 32), SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))])]));
}
