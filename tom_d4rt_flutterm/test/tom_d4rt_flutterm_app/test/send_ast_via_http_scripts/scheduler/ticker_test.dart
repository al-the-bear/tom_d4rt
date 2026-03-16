import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Deep visual demo for Ticker
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Ticker')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.orange.shade50, shape: BoxShape.circle),
      child: Icon(Icons.timer, size: 60, color: Colors.orange)),
    SizedBox(height: 16),
    Text('Ticker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
    Text('Frame-synchronized callback', style: TextStyle(color: Colors.grey)),
    SizedBox(height: 24),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _InfoBox('60 FPS', 'Typical rate'),
          _InfoBox('~16ms', 'Per frame'),
          _InfoBox('vsync', 'Synchronized'),
        ]),
        SizedBox(height: 16),
        Text('Called once per frame while active', style: TextStyle(fontSize: 12)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Key Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• start() - Begin ticking', style: TextStyle(fontSize: 11)),
        Text('• stop() - Stop ticking', style: TextStyle(fontSize: 11)),
        Text('• muted - Pause without disposal', style: TextStyle(fontSize: 11)),
        Text('• dispose() - Clean up', style: TextStyle(fontSize: 11)),
      ]))
  ])));
}

class _InfoBox extends StatelessWidget {
  final String value; final String label;
  const _InfoBox(this.value, this.label);
  @override Widget build(BuildContext context) => Column(children: [Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.orange)), Text(label, style: TextStyle(fontSize: 10))]);
}
