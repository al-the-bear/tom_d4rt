import 'package:flutter/material.dart';

/// Deep visual demo for ScrollDirection enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Scroll Direction')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ScrollDirection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _DirectionCard('idle', 'Not scrolling', Colors.grey, Icons.pause_circle),
    _DirectionCard('forward', 'Towards content start', Colors.green, Icons.arrow_upward),
    _DirectionCard('reverse', 'Towards content end', Colors.blue, Icons.arrow_downward),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Note: forward/reverse are relative to scroll direction', textAlign: TextAlign.center, style: TextStyle(fontSize: 11))),
  ])));
}

class _DirectionCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final IconData icon;
  const _DirectionCard(this.name, this.desc, this.color, this.icon);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Row(children: [Icon(icon, size: 32, color: color), SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))])]));
}
