import 'package:flutter/material.dart';

/// Deep visual demo for LongPressSemanticsEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('LongPressSemanticsEvent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Container(padding: EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.purple.shade50, shape: BoxShape.circle),
      child: Icon(Icons.touch_app, size: 60, color: Colors.purple)),
    SizedBox(height: 16),
    Text('Long Press Event', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    SizedBox(height: 24),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _Step('1', 'User holds', Icons.touch_app),
        Icon(Icons.arrow_forward, color: Colors.grey),
        _Step('2', '~500ms', Icons.timer),
        Icon(Icons.arrow_forward, color: Colors.grey),
        _Step('3', 'Event fires', Icons.notifications_active),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Accessibility services use this to trigger context menus and secondary actions', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)))
  ])));
}

class _Step extends StatelessWidget {
  final String num; final String label; final IconData icon;
  const _Step(this.num, this.label, this.icon);
  @override Widget build(BuildContext context) => Column(children: [
    CircleAvatar(radius: 16, backgroundColor: Colors.purple, child: Text(num, style: TextStyle(color: Colors.white))),
    SizedBox(height: 8), Icon(icon, color: Colors.purple), Text(label, style: TextStyle(fontSize: 10))]);
}
