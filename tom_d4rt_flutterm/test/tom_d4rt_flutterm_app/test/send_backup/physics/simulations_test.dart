import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Deep visual demo for physics Simulations overview
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Physics Simulations')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Flutter Physics Simulations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: GridView.count(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, children: [
      _SimCard('Spring', Icons.waves, Colors.blue, 'Oscillating motion'),
      _SimCard('Friction', Icons.slow_motion_video, Colors.orange, 'Velocity decay'),
      _SimCard('Gravity', Icons.arrow_downward, Colors.purple, 'Constant acceleration'),
      _SimCard('Clamped', Icons.compress, Colors.teal, 'Bounded range'),
      _SimCard('Bounded Friction', Icons.border_outer, Colors.green, 'Combined limits'),
      _SimCard('Tolerance', Icons.tune, Colors.red, 'Precision control'),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('All simulations implement: x(t), dx(t), isDone(t)', style: TextStyle(fontSize: 12, fontFamily: 'monospace')))
  ])));
}

class _SimCard extends StatelessWidget {
  final String name; final IconData icon; final Color color; final String desc;
  const _SimCard(this.name, this.icon, this.color, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color, size: 32), SizedBox(height: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: color)), Text(desc, style: TextStyle(fontSize: 10), textAlign: TextAlign.center)]));
}
