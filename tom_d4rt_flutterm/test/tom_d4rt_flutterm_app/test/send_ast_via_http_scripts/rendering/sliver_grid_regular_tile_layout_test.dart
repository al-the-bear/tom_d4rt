import 'package:flutter/material.dart';

/// Deep visual demo for SliverGridRegularTileLayout
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Regular Tiles')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverGridRegularTileLayout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Expanded(child: GridView.count(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8,
          children: [for (var i = 0; i < 9; i++) Container(decoration: BoxDecoration(color: Colors.teal.shade200, borderRadius: BorderRadius.circular(4)),
            child: Center(child: Text('${i + 1}', style: TextStyle(fontWeight: FontWeight.bold))))])),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Text('crossAxisCount: 3, mainAxisStride: ${(MediaQuery.of(context).size.width - 32 - 16) / 3}', style: TextStyle(fontFamily: 'monospace', fontSize: 9))),
      ]))),
    SizedBox(height: 8),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('All tiles have same size', style: TextStyle(fontSize: 11))),
  ])));
}
