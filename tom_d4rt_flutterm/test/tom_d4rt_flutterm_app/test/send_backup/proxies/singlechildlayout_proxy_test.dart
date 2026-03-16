import 'package:flutter/material.dart';

/// Deep visual demo for SingleChildLayoutDelegate proxy pattern
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SingleChildLayoutDelegate')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layout Delegation Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: CustomSingleChildLayout(delegate: _CenterRightDelegate(),
        child: Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)), child: Center(child: Text('Child', style: TextStyle(color: Colors.white))))))),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('SingleChildLayoutDelegate methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• getSize(constraints) → Size', style: TextStyle(fontSize: 11)),
        Text('• getConstraintsForChild(constraints) → BoxConstraints', style: TextStyle(fontSize: 11)),
        Text('• getPositionForChild(size, childSize) → Offset', style: TextStyle(fontSize: 11)),
        Text('• shouldRelayout(oldDelegate) → bool', style: TextStyle(fontSize: 11)),
      ]))
  ])));
}

class _CenterRightDelegate extends SingleChildLayoutDelegate {
  @override Size getSize(BoxConstraints constraints) => constraints.biggest;
  @override BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();
  @override Offset getPositionForChild(Size size, Size childSize) => Offset(size.width - childSize.width - 20, (size.height - childSize.height) / 2);
  @override bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;
}
