import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Deep visual demo for Assertiveness enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Assertiveness')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Live Region Assertiveness', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 20),
    _AssertCard(Assertiveness.polite, 'Polite', 'Announces when idle', Icons.record_voice_over, Colors.green, 'Low priority updates'),
    SizedBox(height: 12),
    _AssertCard(Assertiveness.assertive, 'Assertive', 'Interrupts current speech', Icons.campaign, Colors.red, 'Critical alerts'),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text('ARIA aria-live equivalent', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text('Controls how screen readers announce dynamic content changes', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
  ])));
}

class _AssertCard extends StatelessWidget {
  final Assertiveness level; final String name; final String desc; final IconData icon; final Color color; final String example;
  const _AssertCard(this.level, this.name, this.desc, this.icon, this.color, this.example);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
    child: Row(children: [Icon(icon, size: 40, color: color), SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(desc), SizedBox(height: 4), Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(example, style: TextStyle(fontSize: 10)))]))]));
}
