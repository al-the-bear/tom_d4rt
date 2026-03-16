import 'package:flutter/material.dart';

/// Deep visual demo for MultiChildLayoutDelegate proxy pattern
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MultiChildLayoutDelegate')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Multi-Child Layout Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: CustomMultiChildLayout(delegate: _DiagonalDelegate(),
        children: [
          LayoutId(id: 'top', child: Container(width: 60, height: 60, color: Colors.red, child: Center(child: Text('1', style: TextStyle(color: Colors.white))))),
          LayoutId(id: 'middle', child: Container(width: 60, height: 60, color: Colors.green, child: Center(child: Text('2', style: TextStyle(color: Colors.white))))),
          LayoutId(id: 'bottom', child: Container(width: 60, height: 60, color: Colors.blue, child: Center(child: Text('3', style: TextStyle(color: Colors.white))))),
        ]))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('MultiChildLayoutDelegate:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• performLayout(size)', style: TextStyle(fontSize: 11)),
        Text('• hasChild(childId) → bool', style: TextStyle(fontSize: 11)),
        Text('• layoutChild(childId, constraints) → Size', style: TextStyle(fontSize: 11)),
        Text('• positionChild(childId, offset)', style: TextStyle(fontSize: 11)),
      ]))
  ])));
}

class _DiagonalDelegate extends MultiChildLayoutDelegate {
  @override void performLayout(Size size) {
    final ids = ['top', 'middle', 'bottom'];
    for (int i = 0; i < ids.length; i++) {
      if (hasChild(ids[i])) {
        final childSize = layoutChild(ids[i], BoxConstraints.loose(size));
        positionChild(ids[i], Offset(i * 80.0, i * 80.0));
      }
    }
  }
  @override bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
