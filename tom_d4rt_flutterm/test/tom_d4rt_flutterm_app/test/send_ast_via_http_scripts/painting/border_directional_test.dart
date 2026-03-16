import 'package:flutter/material.dart';

/// Deep visual demo for BorderDirectional
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BorderDirectional Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 150, height: 100, decoration: BoxDecoration(color: Colors.grey.shade100, border: BorderDirectional(start: BorderSide(width: 4, color: Colors.blue), end: BorderSide(width: 4, color: Colors.red), top: BorderSide(width: 2, color: Colors.green), bottom: BorderSide(width: 2, color: Colors.orange))), child: Center(child: Text('LTR'))), SizedBox(height: 20), Directionality(textDirection: TextDirection.rtl, child: Container(width: 150, height: 100, decoration: BoxDecoration(color: Colors.grey.shade100, border: BorderDirectional(start: BorderSide(width: 4, color: Colors.blue), end: BorderSide(width: 4, color: Colors.red))), child: Center(child: Text('RTL'))))])));
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
