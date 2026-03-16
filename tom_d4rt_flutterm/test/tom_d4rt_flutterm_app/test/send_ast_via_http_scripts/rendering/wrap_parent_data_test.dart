import 'package:flutter/material.dart';

/// Deep visual demo for WrapParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Wrap Parent Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('WrapParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Wrap(children: [
          for (var i = 0; i < 6; i++)
            Container(width: 50, height: 40, margin: EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.cyan.shade200, borderRadius: BorderRadius.circular(4)),
              child: Center(child: Text('${i + 1}', style: TextStyle(fontWeight: FontWeight.bold)))),
        ]),
        SizedBox(height: 16),
        _Field('runIndex', 'Which row/column (run)'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Parent data for Wrap children', style: TextStyle(fontSize: 11))),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
