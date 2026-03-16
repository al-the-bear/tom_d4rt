import 'package:flutter/material.dart';

/// Deep visual demo for AdvancedDecorations
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Advanced Decorations Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [Container(width: 200, height: 100, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.purple]), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 10, offset: Offset(0, 5))])), SizedBox(height: 20), Container(width: 200, height: 100, decoration: BoxDecoration(gradient: RadialGradient(colors: [Colors.orange, Colors.red]), shape: BoxShape.circle)), SizedBox(height: 20), Container(width: 200, height: 100, decoration: BoxDecoration(border: Border.all(width: 3, color: Colors.green), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30))))])));
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
