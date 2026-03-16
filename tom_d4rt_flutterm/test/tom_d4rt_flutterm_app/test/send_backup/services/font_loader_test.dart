import 'package:flutter/material.dart';

/// Deep visual demo for FontLoader
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Font Loader')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('FontLoader', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.font_download, size: 48, color: Colors.pink),
        SizedBox(height: 12),
        Text('Dynamic Font Loading', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _Method('addFont', 'Add font data'),
        _Method('load', 'Register with engine'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text('Example:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        Text("FontLoader('MyFont')..addFont(data)..load()", style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
      ])),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
