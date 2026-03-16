import 'package:flutter/material.dart';

/// Deep visual demo for image cache management
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Cache Manager')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ImageCache', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.cached, size: 48, color: Colors.orange),
        SizedBox(height: 12),
        _Field('maximumSize', 'Max cached images'),
        _Field('maximumSizeBytes', 'Max cache bytes'),
        _Field('currentSize', 'Current count'),
        _Field('currentSizeBytes', 'Current bytes'),
      ])),
    SizedBox(height: 16),
    _Method('evict', 'Remove specific image'),
    _Method('clear', 'Clear entire cache'),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
