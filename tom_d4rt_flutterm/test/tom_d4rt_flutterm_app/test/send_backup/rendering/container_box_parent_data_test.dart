import 'package:flutter/material.dart';

/// Deep visual demo for ContainerBoxParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ContainerBoxParentData')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Box Parent Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _Box('Parent', Colors.green, 120),
        ]),
        SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(children: [Icon(Icons.arrow_downward, color: Colors.green), _Data('offset', '(10,20)')]),
          Column(children: [Icon(Icons.arrow_downward, color: Colors.green), _Data('offset', '(80,20)')]),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _Box('Child 1', Colors.blue, 50),
          _Box('Child 2', Colors.orange, 50),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• offset: Offset - position in parent', style: TextStyle(fontSize: 11)),
        Text('• (from ContainerParentDataMixin)', style: TextStyle(fontSize: 11, color: Colors.grey)),
        Text('• previousSibling / nextSibling', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _Box extends StatelessWidget {
  final String label; final Color color; final double size;
  const _Box(this.label, this.color, this.size);
  @override Widget build(BuildContext context) => Container(width: size, height: 40, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
    child: Center(child: Text(label, style: TextStyle(color: Colors.white, fontSize: 10))));
}

class _Data extends StatelessWidget {
  final String name; final String value;
  const _Data(this.name, this.value);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
    child: Text('$name: $value', style: TextStyle(fontSize: 9, fontFamily: 'monospace')));
}
