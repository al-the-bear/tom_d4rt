import 'package:flutter/material.dart';

/// Deep visual demo for MultiChildLayoutParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MultiChild Layout Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Multi Child Layout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomMultiChildLayout(delegate: _DemoDelegate(), children: [
      LayoutId(id: 'header', child: Container(color: Colors.blue, child: Center(child: Text('Header', style: TextStyle(color: Colors.white))))),
      LayoutId(id: 'body', child: Container(color: Colors.orange, child: Center(child: Text('Body', style: TextStyle(color: Colors.white))))),
      LayoutId(id: 'footer', child: Container(color: Colors.green, child: Center(child: Text('Footer', style: TextStyle(color: Colors.white))))),
    ])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('ParentData stores:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• id: Object identifier', style: TextStyle(fontSize: 11)),
        Text('• offset: Position from BoxParentData', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _DemoDelegate extends MultiChildLayoutDelegate {
  @override void performLayout(Size size) {
    final headerSize = layoutChild('header', BoxConstraints.tight(Size(size.width, 60)));
    positionChild('header', Offset.zero);
    final footerSize = layoutChild('footer', BoxConstraints.tight(Size(size.width, 60)));
    positionChild('footer', Offset(0, size.height - footerSize.height));
    layoutChild('body', BoxConstraints.tight(Size(size.width, size.height - headerSize.height - footerSize.height)));
    positionChild('body', Offset(0, headerSize.height));
  }
  @override bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
