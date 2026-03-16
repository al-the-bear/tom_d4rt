import 'package:flutter/material.dart';

/// Deep visual demo for RenderSemanticsGestureHandler
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Semantics Gestures')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantic Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _GestureCard('onTap', 'Primary action', Icons.touch_app, Colors.blue),
      _GestureCard('onLongPress', 'Secondary action', Icons.pan_tool, Colors.green),
      _GestureCard('onScrollLeft', 'Scroll left', Icons.arrow_back, Colors.orange),
      _GestureCard('onScrollRight', 'Scroll right', Icons.arrow_forward, Colors.orange),
      _GestureCard('onIncrease', 'Increase value', Icons.add, Colors.purple),
      _GestureCard('onDecrease', 'Decrease value', Icons.remove, Colors.purple),
      _GestureCard('onDismiss', 'Dismiss item', Icons.close, Colors.red),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Semantic actions called by screen readers', style: TextStyle(fontSize: 11))),
  ])));
}

class _GestureCard extends StatelessWidget {
  final String name; final String desc; final IconData icon; final MaterialColor color;
  const _GestureCard(this.name, this.desc, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(icon, color: color, size: 20), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
