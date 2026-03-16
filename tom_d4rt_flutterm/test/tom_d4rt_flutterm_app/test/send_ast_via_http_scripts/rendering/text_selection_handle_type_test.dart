import 'package:flutter/material.dart';

/// Deep visual demo for TextSelectionHandleType enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Handle Types')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TextSelectionHandleType', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _HandleCard('left', 'Start handle (LTR)', Icons.chevron_left, Colors.blue),
    _HandleCard('right', 'End handle (LTR)', Icons.chevron_right, Colors.green),
    _HandleCard('collapsed', 'Cursor (no selection)', Icons.edit, Colors.orange),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Note: In RTL text, left/right are swapped', style: TextStyle(fontSize: 11))),
  ])));
}

class _HandleCard extends StatelessWidget {
  final String name; final String desc; final IconData icon; final MaterialColor color;
  const _HandleCard(this.name, this.desc, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Container(width: 40, height: 40, decoration: BoxDecoration(color: color.shade200, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color.shade700)),
      SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 14)), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))])),
    ]));
}
