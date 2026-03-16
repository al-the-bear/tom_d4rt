import 'package:flutter/material.dart';

/// Deep visual demo for ShapeBorderClipper
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Shape Clipper')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ShapeBorderClipper', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Row(children: [
      Expanded(child: ClipPath(clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        child: Container(height: 100, color: Colors.red.shade200, child: Center(child: Text('Rounded', style: TextStyle(fontWeight: FontWeight.bold)))))),
      SizedBox(width: 8),
      Expanded(child: ClipPath(clipper: ShapeBorderClipper(shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20))),
        child: Container(height: 100, color: Colors.blue.shade200, child: Center(child: Text('Beveled', style: TextStyle(fontWeight: FontWeight.bold)))))),
    ]),
    SizedBox(height: 8),
    Row(children: [
      Expanded(child: ClipPath(clipper: ShapeBorderClipper(shape: StadiumBorder()),
        child: Container(height: 60, color: Colors.green.shade200, child: Center(child: Text('Stadium', style: TextStyle(fontWeight: FontWeight.bold)))))),
      SizedBox(width: 8),
      Expanded(child: ClipPath(clipper: ShapeBorderClipper(shape: CircleBorder()),
        child: Container(height: 60, width: 60, color: Colors.orange.shade200, child: Center(child: Text('Circle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)))))),
    ]),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Clips using ShapeBorder.getOuterPath', style: TextStyle(fontSize: 11))),
  ])));
}
