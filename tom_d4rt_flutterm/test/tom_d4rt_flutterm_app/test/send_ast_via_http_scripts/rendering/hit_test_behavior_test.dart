import 'package:flutter/material.dart';

/// Deep visual demo for HitTestBehavior enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('HitTestBehavior')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Hit Test Behavior', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _BehaviorDemo(HitTestBehavior.deferToChild, 'deferToChild', 'Only hit if child is hit', Colors.blue),
    SizedBox(height: 8),
    _BehaviorDemo(HitTestBehavior.opaque, 'opaque', 'Always absorbs hits in bounds', Colors.orange),
    SizedBox(height: 8),
    _BehaviorDemo(HitTestBehavior.translucent, 'translucent', 'Captures and passes through', Colors.green),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Controls how GestureDetector responds to pointer events in empty areas', style: TextStyle(fontSize: 12))),
  ])));
}

class _BehaviorDemo extends StatelessWidget {
  final HitTestBehavior behavior; final String name; final String desc; final Color color;
  const _BehaviorDemo(this.behavior, this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Row(children: [Icon(Icons.touch_app, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')), Text(desc, style: TextStyle(fontSize: 11))]))]));
}
