import 'package:flutter/material.dart';

/// Deep visual demo for AppLifecycleState enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Lifecycle State')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('AppLifecycleState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _StateFlow(),
        SizedBox(height: 16),
        Text('Lifecycle Flow', style: TextStyle(fontWeight: FontWeight.bold)),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('App state from ServicesBinding.lifecycleState', style: TextStyle(fontSize: 11))),
  ])));
}

class _StateFlow extends StatelessWidget {
  @override Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    _State('detached', Colors.grey),
    Icon(Icons.arrow_forward, size: 16),
    _State('resumed', Colors.green),
    Icon(Icons.arrow_forward, size: 16),
    _State('inactive', Colors.orange),
    Icon(Icons.arrow_forward, size: 16),
    _State('paused', Colors.red),
  ]);
}

class _State extends StatelessWidget {
  final String name; final MaterialColor color;
  const _State(this.name, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(horizontal: 2), padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4), decoration: BoxDecoration(color: color.shade100, borderRadius: BorderRadius.circular(4)),
    child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 8)));
}
