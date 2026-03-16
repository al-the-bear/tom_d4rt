import 'package:flutter/material.dart';

/// Deep visual demo for ListWheelParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Wheel Parent Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('List Wheel Item Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _WheelItem(-2, 0.3), _WheelItem(-1, 0.6), _WheelItem(0, 1.0), _WheelItem(1, 0.6), _WheelItem(2, 0.3),
        ]),
        SizedBox(height: 12),
        Text('Each item stores its position data', style: TextStyle(fontSize: 12)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('ListWheelParentData:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• index: Child index', style: TextStyle(fontSize: 11)),
        Text('• Extends ContainerBoxParentData', style: TextStyle(fontSize: 11)),
        Text('• Used for 3D wheel positioning', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _WheelItem extends StatelessWidget {
  final int offset; final double opacity;
  const _WheelItem(this.offset, this.opacity);
  @override Widget build(BuildContext context) => Transform.scale(scale: opacity, child: Opacity(opacity: opacity, child: Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)),
    child: Center(child: Text('${offset >= 0 ? '+' : ''}$offset', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))));
}
