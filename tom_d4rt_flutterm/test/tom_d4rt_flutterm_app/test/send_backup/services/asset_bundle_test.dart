import 'package:flutter/material.dart';

/// Deep visual demo for AssetBundle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Asset Bundle')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('AssetBundle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.folder, size: 48, color: Colors.amber),
        SizedBox(height: 12),
        Text('Asset Loading Methods', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _Method('loadString', 'Load text file'),
        _Method('load', 'Load binary data'),
        _Method('loadStructuredData', 'Load and parse'),
        _Method('evict', 'Remove from cache'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('DefaultAssetBundle.of(context).loadString(...)', style: TextStyle(fontFamily: 'monospace', fontSize: 9))),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
