import 'package:flutter/material.dart';

/// Deep visual demo for ParentData usage
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ParentData Usage')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Parent Data in Action', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(height: 200, decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
      child: Stack(children: [
        Positioned(left: 10, top: 10, child: _DataBox('top: 10, left: 10', Colors.blue)),
        Positioned(right: 10, bottom: 10, child: _DataBox('bottom: 10, right: 10', Colors.orange)),
        Positioned(left: 0, right: 0, top: 80, child: Center(child: _DataBox('centered', Colors.green))),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('ParentData is attached to each child', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text('Stack uses StackParentData with positioning info', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _DataBox extends StatelessWidget {
  final String label; final Color color;
  const _DataBox(this.label, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(color: Colors.white, fontSize: 10)));
}
