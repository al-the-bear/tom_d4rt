import 'package:flutter/material.dart';

/// Deep visual demo for Accumulator
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Accumulator Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_circle, size: 48, color: Colors.blue), SizedBox(height: 16), Text('Accumulator', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Used internally for text layout'), SizedBox(height: 8), Text('Accumulates values during processing', style: TextStyle(fontSize: 12, color: Colors.grey))]))])));
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
