import 'package:flutter/material.dart';

/// Deep visual demo for ParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ParentData')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Parent Data Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _DataCard('BoxParentData', 'Offset position', Colors.blue),
      _DataCard('FlexParentData', 'Flex factor', Colors.green),
      _DataCard('StackParentData', 'Position in stack', Colors.orange),
      _DataCard('SliverLogicalParentData', 'Sliver offset', Colors.purple),
    ])),
  ])));
}

class _DataCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _DataCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.data_object, color: color), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))]));
}
