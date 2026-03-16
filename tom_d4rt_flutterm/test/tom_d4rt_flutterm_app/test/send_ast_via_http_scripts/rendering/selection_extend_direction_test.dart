import 'package:flutter/material.dart';

/// Deep visual demo for SelectionExtendDirection enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Extend Direction')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionExtendDirection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Row(children: [
      Expanded(child: _DirCard('previousLine', Icons.arrow_upward, Colors.blue)),
      SizedBox(width: 8),
      Expanded(child: _DirCard('nextLine', Icons.arrow_downward, Colors.blue)),
    ]),
    SizedBox(height: 8),
    Row(children: [
      Expanded(child: _DirCard('backward', Icons.arrow_back, Colors.green)),
      SizedBox(width: 8),
      Expanded(child: _DirCard('forward', Icons.arrow_forward, Colors.green)),
    ]),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Keyboard navigation extends selection', style: TextStyle(fontSize: 11))),
  ])));
}

class _DirCard extends StatelessWidget {
  final String name; final IconData icon; final MaterialColor color;
  const _DirCard(this.name, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Column(children: [Icon(icon, size: 32, color: color), SizedBox(height: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10))]));
}
