import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Deep visual demo for SpringDescription
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SpringDescription')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Spring Parameters', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 20),
    Row(children: [
      Expanded(child: _ParamCard('Mass', Icons.fitness_center, Colors.blue, 'Inertia of object', '1.0')),
      SizedBox(width: 12),
      Expanded(child: _ParamCard('Stiffness', Icons.linear_scale, Colors.orange, 'Spring constant k', '100.0')),
    ]),
    SizedBox(height: 12),
    Row(children: [
      Expanded(child: _ParamCard('Damping', Icons.water_drop, Colors.teal, 'Friction coefficient', '10.0')),
      SizedBox(width: 12),
      Expanded(child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(children: [Icon(Icons.calculate, color: Colors.purple), SizedBox(height: 4), Text('Ratio', style: TextStyle(fontWeight: FontWeight.bold)), Text('damping / 2√(mass×stiff)', style: TextStyle(fontSize: 9))]))),
    ]),
    SizedBox(height: 20),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text('Damping Ratio Effects:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _RatioRow('< 1.0', 'Underdamped (oscillates)', Colors.red),
        _RatioRow('= 1.0', 'Critically damped', Colors.green),
        _RatioRow('> 1.0', 'Overdamped (slow)', Colors.blue),
      ]))
  ])));
}

class _ParamCard extends StatelessWidget {
  final String name; final IconData icon; final Color color; final String desc; final String value;
  const _ParamCard(this.name, this.icon, this.color, this.desc, this.value);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
    child: Column(children: [Icon(icon, color: color), SizedBox(height: 4), Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 9)), Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color))]));
}

class _RatioRow extends StatelessWidget {
  final String ratio; final String effect; final Color color;
  const _RatioRow(this.ratio, this.effect, this.color);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(ratio, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))), SizedBox(width: 8), Text(effect, style: TextStyle(fontSize: 11))]));
}
