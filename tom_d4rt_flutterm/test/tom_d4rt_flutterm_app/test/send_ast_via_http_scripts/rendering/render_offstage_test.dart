import 'package:flutter/material.dart';

/// Deep visual demo for RenderOffstage
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Offstage')), body: _OffstageDemo());
}

class _OffstageDemo extends StatefulWidget {
  @override State<_OffstageDemo> createState() => _OffstageDemoState();
}

class _OffstageDemoState extends State<_OffstageDemo> {
  bool _offstage = false;
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Offstage Widget', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    ElevatedButton(onPressed: () => setState(() => _offstage = !_offstage), child: Text(_offstage ? 'Show Widget' : 'Hide Widget')),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Center(child: Offstage(offstage: _offstage,
          child: Container(width: 200, height: 150, decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green)),
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.visibility, size: 48, color: Colors.green), Text('Visible', style: TextStyle(fontWeight: FontWeight.bold))]))))),
        if (_offstage) Center(child: Text('Widget is offstage', style: TextStyle(color: Colors.grey))),
      ]))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('offstage: true hides but keeps state (unlike if-else)', style: TextStyle(fontSize: 11))),
  ]));
}
