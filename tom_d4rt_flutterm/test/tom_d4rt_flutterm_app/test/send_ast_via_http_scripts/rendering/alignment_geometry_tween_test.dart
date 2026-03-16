import 'package:flutter/material.dart';

/// Deep visual demo for AlignmentGeometryTween
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AlignmentGeometryTween')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Alignment Geometry Animation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
      child: TweenAnimationBuilder<Alignment>(
        tween: AlignmentTween(begin: Alignment.topLeft, end: Alignment.bottomRight),
        duration: Duration(seconds: 3),
        builder: (context, alignment, _) => Align(alignment: alignment,
          child: Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Center(child: Icon(Icons.widgets, color: Colors.white))))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('AlignmentGeometryTween:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• begin: Starting alignment', style: TextStyle(fontSize: 11)),
        Text('• end: Ending alignment', style: TextStyle(fontSize: 11)),
        Text('• lerp: Linear interpolation', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
