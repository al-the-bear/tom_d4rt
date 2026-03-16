import 'package:flutter/material.dart';

/// Deep visual demo for LayerLink (connects Leader and Follower layers)
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('LayerLink')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layer Linking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _LinkBox('Leader', Icons.location_on, Colors.blue),
          Icon(Icons.link, color: Colors.orange, size: 32),
          _LinkBox('Follower', Icons.my_location, Colors.green),
        ]),
        SizedBox(height: 12),
        Text('LayerLink connects two positioned layers', style: TextStyle(fontSize: 12)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Use case:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• CompositedTransformTarget (leader)', style: TextStyle(fontSize: 11)),
        Text('• CompositedTransformFollower (follower)', style: TextStyle(fontSize: 11)),
        Text('• Overlays, tooltips, dropdowns', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _LinkBox extends StatelessWidget {
  final String label; final IconData icon; final Color color;
  const _LinkBox(this.label, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Column(children: [Icon(icon, color: color), Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color))]));
}
