import 'package:flutter/material.dart';

/// Deep visual demo for BoxHitTestResult
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BoxHitTestResult')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Hit Test Result', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _HitBox('Box A', Colors.blue, true),
          Icon(Icons.arrow_forward),
          _HitBox('Box B', Colors.orange, true),
          Icon(Icons.arrow_forward),
          _HitBox('Box C', Colors.green, false),
        ]),
        SizedBox(height: 12),
        Text('Hit test traverses from root to leaf', style: TextStyle(fontSize: 12)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('BoxHitTestResult:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• path: List<BoxHitTestEntry>', style: TextStyle(fontSize: 11)),
        Text('• add(entry): Add to path', style: TextStyle(fontSize: 11)),
        Text('• addWithPaintTransform(): Transform coords', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _HitBox extends StatelessWidget {
  final String label; final Color color; final bool hit;
  const _HitBox(this.label, this.color, this.hit);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(horizontal: 4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: color, width: hit ? 2 : 1)),
    child: Column(children: [Text(label, style: TextStyle(fontSize: 11)), if (hit) Icon(Icons.check, color: color, size: 16)]));
}
