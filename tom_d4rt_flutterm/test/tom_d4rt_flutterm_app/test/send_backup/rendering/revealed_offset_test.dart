import 'package:flutter/material.dart';

/// Deep visual demo for RevealedOffset
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Revealed Offset')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('RevealedOffset', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.visibility, size: 48, color: Colors.cyan),
        SizedBox(height: 12),
        Text('Scroll Position Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 12),
        _Field('offset', 'double - Scroll position to reveal'),
        _Field('rect', 'Rect - Visible area bounds'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by RenderAbstractViewport.getOffsetToReveal', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), SizedBox(width: 8), Expanded(child: Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey)))]));
}
