import 'package:flutter/material.dart';

/// Deep visual demo for BoxConstraints
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BoxConstraints')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Box Constraints', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(height: 150, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 2, strokeAlign: BorderSide.strokeAlignOutside)),
      child: LayoutBuilder(builder: (context, constraints) => Stack(children: [
        Container(width: constraints.maxWidth, height: constraints.maxHeight, color: Colors.red.withOpacity(0.1)),
        Container(width: constraints.maxWidth * 0.5, height: constraints.maxHeight * 0.5, color: Colors.blue.withOpacity(0.3)),
        Positioned(bottom: 4, right: 4, child: Text('max: ${constraints.maxWidth.toInt()}x${constraints.maxHeight.toInt()}', style: TextStyle(fontSize: 10))),
      ]))),
    SizedBox(height: 16),
    Expanded(child: GridView.count(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 2, children: [
      _ConstraintCard('tight(size)', 'Exact size'),
      _ConstraintCard('loose(size)', '0 to size'),
      _ConstraintCard('expand()', 'Fill parent'),
      _ConstraintCard('shrinkWrap', 'Min possible'),
    ])),
  ])));
}

class _ConstraintCard extends StatelessWidget {
  final String name; final String desc;
  const _ConstraintCard(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
