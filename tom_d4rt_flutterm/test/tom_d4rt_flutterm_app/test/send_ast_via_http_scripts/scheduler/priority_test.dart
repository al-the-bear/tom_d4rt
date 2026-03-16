import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Deep visual demo for scheduling Priority
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Priority')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Scheduling Priority', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _PriorityCard('idle', Icons.hourglass_empty, Colors.grey, 'Run when nothing else to do'),
    SizedBox(height: 8),
    _PriorityCard('animation', Icons.animation, Colors.blue, 'Frame-critical updates'),
    SizedBox(height: 8),
    _PriorityCard('touch', Icons.touch_app, Colors.orange, 'User input response'),
    SizedBox(height: 8),
    _PriorityCard('kMaxOffset', Icons.priority_high, Colors.red, 'Maximum priority value'),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Higher priority tasks run first', style: TextStyle(fontSize: 12)))
  ])));
}

class _PriorityCard extends StatelessWidget {
  final String name; final IconData icon; final Color color; final String desc;
  const _PriorityCard(this.name, this.icon, this.color, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Row(children: [Icon(icon, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 11))]))]));
}
