import 'package:flutter/material.dart';

/// Deep visual demo for KeyboardInsertedContent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Keyboard Content')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('KeyboardInsertedContent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lime.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.image, size: 48, color: Colors.lime),
        SizedBox(height: 12),
        Text('Rich Content from Keyboard', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _Field('mimeType', 'Content MIME type'),
        _Field('uri', 'Content URI'),
        _Field('data', 'Raw byte data'),
        _Field('hasData', 'Has embedded bytes'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('GIFs, images, etc. inserted via keyboard', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
