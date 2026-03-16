import 'package:flutter/material.dart';

/// Deep visual demo for RendererBinding
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('RendererBinding')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Render Pipeline Binding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _BindingStep('1', 'Create root render object'),
        Icon(Icons.arrow_downward, color: Colors.deepPurple),
        _BindingStep('2', 'Schedule frame callbacks'),
        Icon(Icons.arrow_downward, color: Colors.deepPurple),
        _BindingStep('3', 'Pump render pipeline'),
        Icon(Icons.arrow_downward, color: Colors.deepPurple),
        _BindingStep('4', 'Composite to screen'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('RendererBinding is the glue between widget trees and rendering', style: TextStyle(fontSize: 11))),
  ])));
}

class _BindingStep extends StatelessWidget {
  final String num; final String text;
  const _BindingStep(this.num, this.text);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(8),
    child: Row(children: [CircleAvatar(radius: 14, backgroundColor: Colors.deepPurple, child: Text(num, style: TextStyle(color: Colors.white, fontSize: 12))), SizedBox(width: 12), Text(text, style: TextStyle(fontWeight: FontWeight.bold))]));
}
