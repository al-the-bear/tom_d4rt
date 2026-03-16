import 'package:flutter/material.dart';

/// Deep visual demo for gradient rendering
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Gradient Rendering')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Gradient Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: GridView.count(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, children: [
      _GradDemo('Linear', LinearGradient(colors: [Colors.blue, Colors.purple])),
      _GradDemo('Radial', RadialGradient(colors: [Colors.orange, Colors.red])),
      _GradDemo('Sweep', SweepGradient(colors: [Colors.green, Colors.teal, Colors.green])),
      _GradDemo('Stops', LinearGradient(colors: [Colors.red, Colors.yellow, Colors.green], stops: [0.0, 0.3, 1.0])),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Gradients are rendered as shader-based fills', style: TextStyle(fontSize: 11))),
  ])));
}

class _GradDemo extends StatelessWidget {
  final String name; final Gradient gradient;
  const _GradDemo(this.name, this.gradient);
  @override Widget build(BuildContext context) => Column(children: [
    Expanded(child: Container(decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(8)))),
    SizedBox(height: 4),
    Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
  ]);
}
