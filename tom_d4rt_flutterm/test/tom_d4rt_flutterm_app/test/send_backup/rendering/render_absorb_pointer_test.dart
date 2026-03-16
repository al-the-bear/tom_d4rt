import 'package:flutter/material.dart';

/// Deep visual demo for RenderAbsorbPointer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AbsorbPointer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Pointer Absorption', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Row(children: [
      Expanded(child: _AbsorbDemo(true, 'absorbing: true', Colors.red)),
      SizedBox(width: 8),
      Expanded(child: _AbsorbDemo(false, 'absorbing: false', Colors.green)),
    ])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('AbsorbPointer prevents events from reaching children and siblings behind', style: TextStyle(fontSize: 11))),
  ])));
}

class _AbsorbDemo extends StatelessWidget {
  final bool absorbing; final String label; final MaterialColor color;
  const _AbsorbDemo(this.absorbing, this.label, this.color);
  @override Widget build(BuildContext context) => AbsorbPointer(absorbing: absorbing,
    child: GestureDetector(onTap: () {},
      child: Container(decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(absorbing ? Icons.block : Icons.touch_app, color: color, size: 48),
          SizedBox(height: 8),
          Text(absorbing ? 'Absorbed' : 'Active', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          Padding(padding: EdgeInsets.all(8), child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 10))),
        ]))));
}
