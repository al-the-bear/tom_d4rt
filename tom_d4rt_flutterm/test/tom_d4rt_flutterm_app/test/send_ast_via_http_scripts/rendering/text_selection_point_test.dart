import 'package:flutter/material.dart';

/// Deep visual demo for TextSelectionPoint
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Point')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TextSelectionPoint', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(height: 80, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Stack(children: [
            Center(child: Text('Selected Text', style: TextStyle(fontSize: 18, backgroundColor: Colors.teal.shade100))),
            Positioned(left: 60, top: 20, child: Container(width: 3, height: 30, color: Colors.teal)),
            Positioned(left: 52, top: 48, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.teal, shape: BoxShape.circle))),
          ])),
        SizedBox(height: 16),
        _Field('point', 'Offset - Handle position'),
        _Field('direction', 'TextDirection - Text flow'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Position data for text selection handles', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
