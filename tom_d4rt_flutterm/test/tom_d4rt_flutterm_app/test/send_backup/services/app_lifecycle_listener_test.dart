import 'package:flutter/material.dart';

/// Deep visual demo for AppLifecycleListener
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Lifecycle Listener')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('AppLifecycleListener', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _StateCard('resumed', 'App visible and responding', Colors.green, Icons.play_arrow),
      _StateCard('inactive', 'App not receiving input', Colors.orange, Icons.pause),
      _StateCard('hidden', 'App not visible', Colors.grey, Icons.visibility_off),
      _StateCard('paused', 'App suspended', Colors.blue, Icons.pause_circle),
      _StateCard('detached', 'Engine still running', Colors.red, Icons.stop),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Listen to app lifecycle state changes', style: TextStyle(fontSize: 11))),
  ])));
}

class _StateCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final IconData icon;
  const _StateCard(this.name, this.desc, this.color, this.icon);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(icon, color: color), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
