import 'package:flutter/material.dart';

/// Deep visual demo for Alignment
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Alignment Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey)), child: Stack(children: [for (final a in [Alignment.topLeft, Alignment.topCenter, Alignment.topRight, Alignment.centerLeft, Alignment.center, Alignment.centerRight, Alignment.bottomLeft, Alignment.bottomCenter, Alignment.bottomRight]) Align(alignment: a, child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.blue.withOpacity(0.7), borderRadius: BorderRadius.circular(8)), child: Center(child: Text(a.toString().split('.').last.substring(0, 2), style: TextStyle(color: Colors.white, fontSize: 10)))))]))), SizedBox(height: 16), Text('9 standard alignment positions', style: TextStyle(color: Colors.grey))])));
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
