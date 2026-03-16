import 'package:flutter/material.dart';

/// Deep visual demo for RenderEditable
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('RenderEditable')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Editable Text Rendering', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    TextField(maxLines: 5, decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Multi-line editable', hintText: 'Enter text here...')),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('RenderEditable handles:', style: TextStyle(fontWeight: FontWeight.bold)),
        _Feature('Text layout and painting'),
        _Feature('Selection rendering'),
        _Feature('Cursor positioning'),
        _Feature('Hit testing for taps'),
        _Feature('Scroll offset for long text'),
      ])),
  ])));
}

class _Feature extends StatelessWidget {
  final String text;
  const _Feature(this.text);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [Icon(Icons.check, size: 16, color: Colors.blue), SizedBox(width: 8), Text(text, style: TextStyle(fontSize: 12))]));
}
