import 'package:flutter/material.dart';

/// Deep visual demo for RenderIgnorePointer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('IgnorePointer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Pointer Ignoring', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Row(children: [
      Expanded(child: _PointerDemo(true, 'ignoring: true', Colors.red)),
      SizedBox(width: 8),
      Expanded(child: _PointerDemo(false, 'ignoring: false', Colors.green)),
    ])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Unlike AbsorbPointer, IgnorePointer lets events pass through', style: TextStyle(fontSize: 11))),
  ])));
}

class _PointerDemo extends StatelessWidget {
  final bool ignoring; final String label; final MaterialColor color;
  const _PointerDemo(this.ignoring, this.label, this.color);
  @override Widget build(BuildContext context) => IgnorePointer(ignoring: ignoring,
    child: GestureDetector(onTap: () {},
      child: Container(decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(ignoring ? Icons.not_interested : Icons.touch_app, color: color, size: 48),
          SizedBox(height: 8),
          Text(ignoring ? 'Ignored' : 'Active', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          Padding(padding: EdgeInsets.all(8), child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 9))),
        ]))));
}
