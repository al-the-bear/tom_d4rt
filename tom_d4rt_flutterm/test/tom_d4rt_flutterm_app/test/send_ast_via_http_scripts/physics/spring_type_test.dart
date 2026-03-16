import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Deep visual demo for SpringType enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SpringType')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Spring Damping Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 20),
    _TypeCard(SpringType.underDamped, 'Under-Damped', 'ζ < 1', Icons.waves, Colors.red, 'Oscillates before settling. Most bouncy.'),
    SizedBox(height: 12),
    _TypeCard(SpringType.criticallyDamped, 'Critically Damped', 'ζ = 1', Icons.check_circle, Colors.green, 'Fastest return without oscillation.'),
    SizedBox(height: 12),
    _TypeCard(SpringType.overDamped, 'Over-Damped', 'ζ > 1', Icons.slow_motion_video, Colors.blue, 'Slow return, no oscillation.'),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('ζ = damping ratio = c / (2√(km))', style: TextStyle(fontFamily: 'monospace', fontSize: 11)))
  ])));
}

class _TypeCard extends StatelessWidget {
  final SpringType type; final String name; final String ratio; final IconData icon; final Color color; final String desc;
  const _TypeCard(this.type, this.name, this.ratio, this.icon, this.color, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
    child: Row(children: [Icon(icon, color: color, size: 36), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(width: 8), Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)), child: Text(ratio, style: TextStyle(color: Colors.white, fontSize: 10)))]), SizedBox(height: 4), Text(desc, style: TextStyle(fontSize: 12))]))]));
}
