import 'package:flutter/material.dart';

/// Deep visual demo for RenderFractionalTranslation
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Fractional Translation')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Fractional Offset', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Center(child: Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('Original', style: TextStyle(color: Colors.grey))))),
        Center(child: FractionalTranslation(translation: Offset(0.5, 0.5),
          child: Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text('Offset 0.5,0.5', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 12)))))),
      ]))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('translation: Offset(0.5, 0.5) moves by 50% of child size', style: TextStyle(fontSize: 11))),
  ])));
}
