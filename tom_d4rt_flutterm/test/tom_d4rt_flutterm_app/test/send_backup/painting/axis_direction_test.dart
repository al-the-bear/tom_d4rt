import 'package:flutter/material.dart';

/// Deep visual demo for AxisDirection
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AxisDirection Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [_DirectionCard('up', Icons.arrow_upward, Colors.blue), _DirectionCard('right', Icons.arrow_forward, Colors.green)]), Row(mainAxisAlignment: MainAxisAlignment.center, children: [_DirectionCard('left', Icons.arrow_back, Colors.orange), _DirectionCard('down', Icons.arrow_downward, Colors.red)])])));
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
