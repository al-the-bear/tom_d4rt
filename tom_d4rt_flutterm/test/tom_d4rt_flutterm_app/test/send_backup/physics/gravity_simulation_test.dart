import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Deep visual demo for GravitySimulation
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('GravitySimulation')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Container(height: 200, decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Positioned(top: 20, left: 0, right: 0, child: Center(child: Column(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle), child: Icon(Icons.arrow_downward, color: Colors.white)),
          SizedBox(height: 8),
          Text('g = 9.81 m/s²', style: TextStyle(fontWeight: FontWeight.bold)),
        ]))),
        Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 30, color: Colors.brown.shade300, child: Center(child: Text('Ground', style: TextStyle(color: Colors.white))))),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('GravitySimulation(a, x, v, end)', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        SizedBox(height: 8),
        _ParamRow('acceleration', 'Gravity constant (9.81)'),
        _ParamRow('distance', 'Starting position'),
        _ParamRow('velocity', 'Initial velocity'),
        _ParamRow('end', 'Target position'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [Icon(Icons.functions, color: Colors.purple), SizedBox(width: 8), Text('x(t) = x₀ + v₀t + ½at²', style: TextStyle(fontFamily: 'monospace'))]))
  ])));
}

class _ParamRow extends StatelessWidget {
  final String name; final String desc;
  const _ParamRow(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [Text('• $name: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text(desc, style: TextStyle(fontSize: 12))]));
}
