import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Deep visual demo for SpringSimulation
dynamic build(BuildContext context) {
  final spring = SpringDescription(mass: 1, stiffness: 100, damping: 10);
  return Scaffold(appBar: AppBar(title: Text('SpringSimulation')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.waves, size: 48, color: Colors.blue),
        SizedBox(height: 8),
        Text('Spring Physics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _Param('Mass', '${spring.mass}'),
          _Param('Stiffness', '${spring.stiffness}'),
          _Param('Damping', '${spring.damping}'),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('SpringSimulation Parameters:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('• spring: SpringDescription', style: TextStyle(fontSize: 12)),
        Text('• start: initial position', style: TextStyle(fontSize: 12)),
        Text('• end: target position', style: TextStyle(fontSize: 12)),
        Text('• velocity: initial velocity', style: TextStyle(fontSize: 12)),
      ])),
    Spacer(),
    Text('Used for natural bouncy animations', style: TextStyle(color: Colors.grey))
  ])));
}

class _Param extends StatelessWidget {
  final String label; final String value;
  const _Param(this.label, this.value);
  @override Widget build(BuildContext context) => Column(children: [Text(label, style: TextStyle(fontSize: 10, color: Colors.grey)), Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]);
}
