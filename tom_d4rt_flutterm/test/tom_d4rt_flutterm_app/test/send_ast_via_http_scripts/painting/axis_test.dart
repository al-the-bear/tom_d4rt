import 'package:flutter/material.dart';

/// Deep visual demo for Axis
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Axis Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('Axis.horizontal', style: TextStyle(fontWeight: FontWeight.bold)), Container(height: 60, child: ListView(scrollDirection: Axis.horizontal, children: [for (int i = 1; i <= 10; i++) Container(width: 60, margin: EdgeInsets.all(4), color: Colors.blue.withOpacity(i / 10), child: Center(child: Text('$i')))])), SizedBox(height: 30), Text('Axis.vertical', style: TextStyle(fontWeight: FontWeight.bold)), Expanded(child: ListView(scrollDirection: Axis.vertical, children: [for (int i = 1; i <= 10; i++) Container(height: 50, margin: EdgeInsets.all(4), color: Colors.green.withOpacity(i / 10), child: Center(child: Text('Item $i')))]))])));
}

class _DirectionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _DirectionCard(this.label, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, height: 80, margin: EdgeInsets.all(8),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color), Text(label, style: TextStyle(fontSize: 10, color: color))]),
    );
  }
}
