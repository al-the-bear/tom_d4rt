import 'package:flutter/material.dart';

/// Deep visual demo for RenderCustomSingleChildLayoutBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Custom Single Layout')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Custom Single-Child Layout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: CustomSingleChildLayout(delegate: _CenteredDelegate(),
        child: Container(width: 150, height: 100, decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('Positioned by delegate', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Delegate methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• getSize: Parent size', style: TextStyle(fontSize: 11)),
        Text('• getConstraintsForChild: Child constraints', style: TextStyle(fontSize: 11)),
        Text('• getPositionForChild: Child offset', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _CenteredDelegate extends SingleChildLayoutDelegate {
  @override Size getSize(BoxConstraints constraints) => constraints.biggest;
  @override BoxConstraints getConstraintsForChild(BoxConstraints constraints) => BoxConstraints.loose(constraints.biggest);
  @override Offset getPositionForChild(Size size, Size childSize) => Offset((size.width - childSize.width) / 2, (size.height - childSize.height) / 2);
  @override bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;
}
