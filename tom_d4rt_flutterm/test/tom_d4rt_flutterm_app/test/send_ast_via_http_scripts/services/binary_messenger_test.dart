import 'package:flutter/material.dart';

/// Deep visual demo for BinaryMessenger
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Binary Messenger')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('BinaryMessenger', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _FlowVisual(),
        SizedBox(height: 16),
        _Method('send', 'Send message to platform'),
        _Method('setMessageHandler', 'Receive from platform'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Low-level platform channel interface', style: TextStyle(fontSize: 11))),
  ])));
}

class _FlowVisual extends StatelessWidget {
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(4)), child: Text('Flutter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
      Expanded(child: Row(children: [Icon(Icons.arrow_forward, size: 14, color: Colors.blue), Text('ByteData', style: TextStyle(fontSize: 8)), Icon(Icons.arrow_forward, size: 14, color: Colors.blue)])),
      Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)), child: Text('Native', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
    ]));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
