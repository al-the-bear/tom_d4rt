import 'package:flutter/material.dart';

/// Deep visual demo for clipboard status
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Clipboard Status')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ClipboardStatusNotifier', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _StatusCard('hasStrings', 'Has text content', Colors.green, Icons.text_snippet),
    _StatusCard('canPaste', 'Paste is allowed', Colors.blue, Icons.paste),
    _StatusCard('empty', 'Clipboard is empty', Colors.grey, Icons.not_interested),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Use to enable/disable paste button', style: TextStyle(fontSize: 11))),
  ])));
}

class _StatusCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final IconData icon;
  const _StatusCard(this.name, this.desc, this.color, this.icon);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Row(children: [Icon(icon, size: 32, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 13)), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))]))]));
}
