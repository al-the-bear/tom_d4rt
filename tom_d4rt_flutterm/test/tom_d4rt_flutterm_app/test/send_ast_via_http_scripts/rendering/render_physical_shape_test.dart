import 'package:flutter/material.dart';

/// Deep visual demo for RenderPhysicalShape
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PhysicalShape')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Custom Physical Shapes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Wrap(spacing: 16, runSpacing: 16, alignment: WrapAlignment.center, children: [
      _ShapeDemo('Circle', BeveledRectangleBorder(borderRadius: BorderRadius.circular(50)), Colors.red),
      _ShapeDemo('Stadium', StadiumBorder(), Colors.green),
      _ShapeDemo('Beveled', BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)), Colors.blue),
      _ShapeDemo('Rounded', RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), Colors.orange),
    ]),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Like PhysicalModel but with custom ShapeBorder', style: TextStyle(fontSize: 11))),
  ])));
}

class _ShapeDemo extends StatelessWidget {
  final String label; final ShapeBorder shape; final MaterialColor color;
  const _ShapeDemo(this.label, this.shape, this.color);
  @override Widget build(BuildContext context) => PhysicalShape(elevation: 6, color: color.shade100, clipper: ShapeBorderClipper(shape: shape), shadowColor: Colors.black45,
    child: Container(width: 100, height: 70, child: Center(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))));
}
