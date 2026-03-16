import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Deep visual demo for physics package classes overview
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Physics Classes')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('flutter/physics.dart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'monospace')),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _ClassTile('Simulation', 'Abstract base class', Colors.blue, true),
      _ClassTile('SpringSimulation', 'Oscillating spring motion', Colors.teal, false),
      _ClassTile('FrictionSimulation', 'Velocity decay over time', Colors.orange, false),
      _ClassTile('GravitySimulation', 'Constant acceleration', Colors.purple, false),
      _ClassTile('ClampedSimulation', 'Bounded position wrapper', Colors.green, false),
      _ClassTile('BoundedFrictionSimulation', 'Friction with bounds', Colors.red, false),
      Divider(),
      _ClassTile('SpringDescription', 'Spring parameters (m,k,c)', Colors.indigo, false),
      _ClassTile('Tolerance', 'Simulation precision', Colors.brown, false),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('import "package:flutter/physics.dart"', style: TextStyle(fontFamily: 'monospace', fontSize: 11)))
  ])));
}

class _ClassTile extends StatelessWidget {
  final String name; final String desc; final Color color; final bool isAbstract;
  const _ClassTile(this.name, this.desc, this.color, this.isAbstract);
  @override Widget build(BuildContext context) => ListTile(
    leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(isAbstract ? Icons.category : Icons.class_, color: color, size: 20)),
    title: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), if (isAbstract) Container(margin: EdgeInsets.only(left: 8), padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(4)), child: Text('abstract', style: TextStyle(color: Colors.white, fontSize: 9)))]),
    subtitle: Text(desc),
  );
}
