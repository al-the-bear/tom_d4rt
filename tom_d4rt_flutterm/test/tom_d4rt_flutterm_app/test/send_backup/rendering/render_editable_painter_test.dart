import 'package:flutter/material.dart';

/// Deep visual demo for RenderEditablePainter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Editable Painter')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Text Field Painting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextField(decoration: InputDecoration(labelText: 'Editable text', border: OutlineInputBorder(), hintText: 'Type here...')),
        SizedBox(height: 12),
        Text('Custom painters for:', style: TextStyle(fontWeight: FontWeight.bold)),
        _FeatureItem('Selection', 'Highlight selected text'),
        _FeatureItem('Cursor', 'Blinking insertion point'),
        _FeatureItem('Composing', 'Underline during input'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('RenderEditablePainter customizes text editing visuals', style: TextStyle(fontSize: 11))),
  ])));
}

class _FeatureItem extends StatelessWidget {
  final String name; final String desc;
  const _FeatureItem(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [Icon(Icons.brush, size: 16, color: Colors.amber), SizedBox(width: 8), Text('$name: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text(desc, style: TextStyle(fontSize: 11))]));
}
