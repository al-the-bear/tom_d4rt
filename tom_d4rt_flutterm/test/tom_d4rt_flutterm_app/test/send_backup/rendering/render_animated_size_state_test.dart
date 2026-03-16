import 'package:flutter/material.dart';

/// Deep visual demo for RenderAnimatedSizeState
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Animated Size State')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Size Animation States', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _StateCard('start', 'Initial state', Colors.blue),
      _StateCard('stable', 'Size unchanged', Colors.green),
      _StateCard('changed', 'Size changed, animating', Colors.orange),
      _StateCard('unstable', 'Still changing', Colors.red),
    ])),
  ])));
}

class _StateCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _StateCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.animation, color: color), SizedBox(width: 8), Text('RenderAnimatedSizeState.$name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, fontFamily: 'monospace')), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
