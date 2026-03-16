import 'package:flutter/material.dart';

/// Deep visual demo for BrowserContextMenu
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Browser Context')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('BrowserContextMenu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.web, size: 48, color: Colors.teal),
        SizedBox(height: 12),
        Text('Web Platform Menu Control', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _Method('disableContextMenu', 'Disable right-click menu'),
        _Method('enableContextMenu', 'Re-enable right-click menu'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Platform-specific: Web only', style: TextStyle(fontSize: 11))),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
