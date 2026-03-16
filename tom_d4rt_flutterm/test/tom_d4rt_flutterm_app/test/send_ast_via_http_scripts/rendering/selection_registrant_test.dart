import 'package:flutter/material.dart';

/// Deep visual demo for SelectionRegistrant
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Registrant')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SelectionRegistrant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.app_registration, size: 48, color: Colors.pink),
        SizedBox(height: 12),
        Text('Registration Lifecycle', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _Step('1', 'Widget enters tree'),
        Icon(Icons.arrow_downward, size: 20, color: Colors.pink),
        _Step('2', 'Registers with SelectionRegistrar'),
        Icon(Icons.arrow_downward, size: 20, color: Colors.pink),
        _Step('3', 'Participates in selection'),
        Icon(Icons.arrow_downward, size: 20, color: Colors.pink),
        _Step('4', 'Unregisters on dispose'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Mixin for selectable RenderObjects', style: TextStyle(fontSize: 11))),
  ])));
}

class _Step extends StatelessWidget {
  final String num; final String text;
  const _Step(this.num, this.text);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [CircleAvatar(radius: 10, backgroundColor: Colors.pink, child: Text(num, style: TextStyle(color: Colors.white, fontSize: 10))), SizedBox(width: 8), Text(text, style: TextStyle(fontSize: 11))]));
}
