import 'package:flutter/material.dart';

/// Deep visual demo for granular text selection extension
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Granular Selection')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Selection Granularity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Hello World Flutter Demo', style: TextStyle(fontSize: 18)),
        SizedBox(height: 16),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _GranChip('Character', Icons.text_fields),
          _GranChip('Word', Icons.space_bar),
          _GranChip('Line', Icons.wrap_text),
          _GranChip('Document', Icons.article),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• forward: bool - direction', style: TextStyle(fontSize: 11)),
        Text('• isEnd: bool - extend end or start', style: TextStyle(fontSize: 11)),
        Text('• granularity: TextGranularity', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _GranChip extends StatelessWidget {
  final String label; final IconData icon;
  const _GranChip(this.label, this.icon);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 16, color: Colors.green), SizedBox(width: 4), Text(label, style: TextStyle(fontSize: 12))]));
}
