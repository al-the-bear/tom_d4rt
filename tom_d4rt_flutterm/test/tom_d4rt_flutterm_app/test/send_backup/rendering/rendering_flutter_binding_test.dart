import 'package:flutter/material.dart';

/// Deep visual demo for RenderingFlutterBinding
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Rendering Binding')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Flutter Binding Stack', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _BindingCard('BindingBase', 'Foundation', Colors.grey),
      _BindingCard('GestureBinding', 'Touch handling', Colors.orange),
      _BindingCard('SchedulerBinding', 'Frame scheduling', Colors.blue),
      _BindingCard('ServicesBinding', 'Platform channels', Colors.green),
      _BindingCard('PaintingBinding', 'Image caching', Colors.purple),
      _BindingCard('SemanticsBinding', 'Accessibility', Colors.teal),
      _BindingCard('RendererBinding', 'Render tree', Colors.red),
      _BindingCard('WidgetsBinding', 'Widget tree', Colors.indigo),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('WidgetsFlutterBinding combines all bindings', style: TextStyle(fontSize: 11))),
  ])));
}

class _BindingCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _BindingCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Row(children: [Icon(Icons.layers, color: color, size: 20), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
