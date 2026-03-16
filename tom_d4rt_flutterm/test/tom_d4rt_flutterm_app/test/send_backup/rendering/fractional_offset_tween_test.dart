import 'package:flutter/material.dart';

/// Deep visual demo for FractionalOffsetTween
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FractionalOffsetTween')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Fractional Offset Animation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: TweenAnimationBuilder<Alignment>(
      tween: AlignmentTween(begin: Alignment(-1, -1), end: Alignment(1, 1)),
      duration: Duration(seconds: 3),
      builder: (context, alignment, _) => Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
        child: Align(alignment: alignment, child: Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('${((alignment.x + 1) / 2 * 100).toInt()}%', style: TextStyle(color: Colors.white, fontSize: 12)))))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text('FractionalOffset(-1, -1) = topLeft', style: TextStyle(fontSize: 11)),
        Text('FractionalOffset(1, 1) = bottomRight', style: TextStyle(fontSize: 11)),
        Text('Values in range [-1.0, 1.0]', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
  ])));
}
