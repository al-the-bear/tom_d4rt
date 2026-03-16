import 'package:flutter/material.dart';

/// Deep visual demo for RelayoutWhenSystemFontsChangeMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Font Change Relayout')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('System Font Changes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(children: [Icon(Icons.font_download, size: 48, color: Colors.indigo), SizedBox(width: 16), Expanded(child: Text('When system fonts change, text layouts need to update', style: TextStyle(fontSize: 14)))]),
        SizedBox(height: 16),
        Row(children: [_FontBox('Aa', 14), _FontBox('Aa', 18), _FontBox('Aa', 22)]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Mixin provides:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Listens to font loading events', style: TextStyle(fontSize: 11)),
        Text('• Marks layout as dirty when fonts change', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _FontBox extends StatelessWidget {
  final String text; final double size;
  const _FontBox(this.text, this.size);
  @override Widget build(BuildContext context) => Expanded(child: Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Center(child: Text(text, style: TextStyle(fontSize: size, fontWeight: FontWeight.bold)))));
}
