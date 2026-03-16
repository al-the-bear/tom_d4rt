import 'package:flutter/material.dart';

/// Deep visual demo for AlignmentTween
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AlignmentTween')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Alignment Interpolation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: TweenAnimationBuilder<Alignment>(
      tween: AlignmentTween(begin: Alignment(-1.0, -1.0), end: Alignment(1.0, 1.0)),
      duration: Duration(seconds: 2),
      builder: (context, align, _) => Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Stack(children: [
          Align(alignment: align, child: Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle))),
          Positioned(bottom: 8, right: 8, child: Text('(${align.x.toStringAsFixed(1)}, ${align.y.toStringAsFixed(1)})', style: TextStyle(fontSize: 10, color: Colors.grey))),
        ])))),
    SizedBox(height: 12),
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _AlignChip('topLeft', Alignment.topLeft),
      _AlignChip('center', Alignment.center),
      _AlignChip('bottomRight', Alignment.bottomRight),
    ]),
  ])));
}

class _AlignChip extends StatelessWidget {
  final String label; final Alignment align;
  const _AlignChip(this.label, this.align);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(label, style: TextStyle(fontSize: 10)));
}
