import 'package:flutter/material.dart';

/// Deep visual demo for RenderProxyBoxWithHitTestBehavior
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('HitTest Behaviors')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Hit Test Behavior', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _BehaviorCard('deferToChild', 'Hit test only passes if child is hit', Colors.blue),
      _BehaviorCard('opaque', 'Always receives events, blocks below', Colors.green),
      _BehaviorCard('translucent', 'Receives events but lets them pass through', Colors.orange),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Controls how GestureDetector handles hits', style: TextStyle(fontSize: 11))),
  ])));
}

class _BehaviorCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _BehaviorCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Icon(Icons.touch_app, color: color), SizedBox(width: 8), Text('HitTestBehavior.$name', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12))]),
      SizedBox(height: 8),
      Text(desc, style: TextStyle(fontSize: 12)),
    ]));
}
