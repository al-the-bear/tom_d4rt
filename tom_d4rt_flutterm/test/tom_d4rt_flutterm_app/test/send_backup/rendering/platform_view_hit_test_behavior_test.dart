import 'package:flutter/material.dart';

/// Deep visual demo for PlatformViewHitTestBehavior
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Platform Hit Test')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Hit Test Behaviors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _BehaviorCard('opaque', 'Consume all touch', Colors.blue),
      _BehaviorCard('translucent', 'Pass through to Flutter', Colors.green),
      _BehaviorCard('transparent', 'Fully transparent to touch', Colors.orange),
    ])),
  ])));
}

class _BehaviorCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _BehaviorCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.touch_app, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('PlatformViewHitTestBehavior.$name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, fontFamily: 'monospace')), Text(desc, style: TextStyle(fontSize: 11))]))]));
}
