import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsHandle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SemanticsHandle')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.pan_tool, size: 48, color: Colors.purple),
    SizedBox(height: 8),
    Text('Semantics Handle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Reference-counted access to semantics tree', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _HandleOp('acquire()', Colors.green),
          Icon(Icons.arrow_forward),
          _HandleOp('use...', Colors.blue),
          Icon(Icons.arrow_forward),
          _HandleOp('dispose()', Colors.red),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Purpose:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Keep semantics tree alive', style: TextStyle(fontSize: 11)),
        Text('• Allow external inspection', style: TextStyle(fontSize: 11)),
        Text('• Testing & debugging', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _HandleOp extends StatelessWidget {
  final String label; final Color color;
  const _HandleOp(this.label, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)));
}
