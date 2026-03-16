import 'package:flutter/material.dart';

/// Deep visual demo for SelectionResult enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Result')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionResult', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _ResultCard('none', 'No selection change', Colors.grey, Icons.not_interested),
    _ResultCard('end', 'Selection completed', Colors.green, Icons.check_circle),
    _ResultCard('next', 'Continue to next', Colors.blue, Icons.arrow_forward),
    _ResultCard('previous', 'Continue to previous', Colors.blue, Icons.arrow_back),
    _ResultCard('pending', 'Awaiting more input', Colors.orange, Icons.hourglass_empty),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Return value from dispatchSelectionEvent', style: TextStyle(fontSize: 11))),
  ])));
}

class _ResultCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final IconData icon;
  const _ResultCard(this.name, this.desc, this.color, this.icon);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(icon, color: color), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
