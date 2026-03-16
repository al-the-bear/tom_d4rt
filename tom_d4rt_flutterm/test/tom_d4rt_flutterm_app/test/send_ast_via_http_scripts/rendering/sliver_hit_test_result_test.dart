import 'package:flutter/material.dart';

/// Deep visual demo for SliverHitTestResult
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Hit Result')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverHitTestResult', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _StepVisual(),
        SizedBox(height: 16),
        _Method('addWithAxisOffset', 'Add entry with offset transform'),
        _Method('addWithOutOfBandPosition', 'Add floating position entry'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Collects all slivers hit during pointer event', style: TextStyle(fontSize: 11))),
  ])));
}

class _StepVisual extends StatelessWidget {
  @override Widget build(BuildContext context) => Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Stack(children: [
      Positioned(left: 40, top: 10, child: Container(width: 80, height: 30, decoration: BoxDecoration(color: Colors.deepOrange.shade100, borderRadius: BorderRadius.circular(4)), child: Center(child: Text('Sliver 1', style: TextStyle(fontSize: 10))))),
      Positioned(left: 40, top: 45, child: Container(width: 80, height: 30, decoration: BoxDecoration(color: Colors.deepOrange.shade200, borderRadius: BorderRadius.circular(4)), child: Center(child: Text('Sliver 2', style: TextStyle(fontSize: 10))))),
      Positioned(left: 140, top: 35, child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
      Positioned(left: 155, top: 30, child: Text('Tap', style: TextStyle(fontSize: 10))),
    ]));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 9)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
