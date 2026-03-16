import 'package:flutter/material.dart';

/// Deep visual demo for Semantics Events overview
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Semantics Events')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Accessibility Events', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: GridView.count(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 1.5, children: [
      _EventCard('Tap', Icons.touch_app, Colors.blue),
      _EventCard('Long Press', Icons.pan_tool, Colors.purple),
      _EventCard('Focus', Icons.center_focus_strong, Colors.green),
      _EventCard('Scroll', Icons.swap_vert, Colors.orange),
      _EventCard('Announce', Icons.campaign, Colors.red),
      _EventCard('Tooltip', Icons.info, Colors.teal),
    ])),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Events dispatched to accessibility services for screen readers and assistive tech', textAlign: TextAlign.center, style: TextStyle(fontSize: 11))),
  ])));
}

class _EventCard extends StatelessWidget {
  final String name; final IconData icon; final Color color;
  const _EventCard(this.name, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color, size: 28), SizedBox(height: 4), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]));
}
