import 'package:flutter/material.dart';

/// Deep visual demo for directional text selection extension
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Extend Selection')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Directional Selection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        RichText(text: TextSpan(style: TextStyle(fontSize: 18, color: Colors.black), children: [
          TextSpan(text: 'Hello '),
          TextSpan(text: 'World', style: TextStyle(backgroundColor: Colors.blue.shade200)),
          TextSpan(text: ' Flutter'),
        ])),
        SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _DirButton(Icons.arrow_back, 'Left'),
          SizedBox(width: 16),
          _DirButton(Icons.arrow_forward, 'Right'),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• direction: SelectionExtendDirection', style: TextStyle(fontSize: 11)),
        Text('• isEnd: bool - extend end or start', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _DirButton extends StatelessWidget {
  final IconData icon; final String label;
  const _DirButton(this.icon, this.label);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(icon, color: Colors.white), SizedBox(width: 4), Text(label, style: TextStyle(color: Colors.white))]));
}
