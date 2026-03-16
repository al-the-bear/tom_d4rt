import 'package:flutter/material.dart';

/// Deep visual demo for BorderRadius
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BorderRadius Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Wrap(spacing: 16, runSpacing: 16, children: [Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)), child: Center(child: Text('8', style: TextStyle(color: Colors.white)))), Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)), child: Center(child: Text('20', style: TextStyle(color: Colors.white)))), Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(40)), child: Center(child: Text('40', style: TextStyle(color: Colors.white)))), Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.only(topLeft: Radius.circular(30))), child: Center(child: Text('TL', style: TextStyle(color: Colors.white)))), Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.horizontal(left: Radius.circular(40))), child: Center(child: Text('H', style: TextStyle(color: Colors.white)))), Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.vertical(top: Radius.circular(40))), child: Center(child: Text('V', style: TextStyle(color: Colors.white))))])));
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
