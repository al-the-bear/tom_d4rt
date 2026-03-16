import 'package:flutter/material.dart';

/// Deep visual demo for RenderPhysicalModel
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PhysicalModel')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Physical Model Shape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Wrap(spacing: 12, runSpacing: 12, alignment: WrapAlignment.center, children: [
      for (double e in [0, 4, 8, 16]) PhysicalModel(elevation: e, color: Colors.blue.shade100, borderRadius: BorderRadius.circular(12), shadowColor: Colors.black54,
        child: Container(width: 100, height: 80, child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text('Elevation', style: TextStyle(fontSize: 10)), Text('${e.toInt()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))])))),
    ]),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Creates physical shadows and clips to shape', style: TextStyle(fontSize: 11))),
  ])));
}
