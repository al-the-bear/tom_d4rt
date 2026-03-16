import 'package:flutter/material.dart';

/// Deep visual demo for AutomaticNotchedShape
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AutomaticNotchedShape Demo')), floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)), floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, bottomNavigationBar: BottomAppBar(shape: AutomaticNotchedShape(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), StadiumBorder()), notchMargin: 8, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [IconButton(icon: Icon(Icons.home), onPressed: () {}), SizedBox(width: 48), IconButton(icon: Icon(Icons.settings), onPressed: () {})])));
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
