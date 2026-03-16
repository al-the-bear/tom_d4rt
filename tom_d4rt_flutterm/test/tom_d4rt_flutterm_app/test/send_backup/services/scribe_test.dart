import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for Scribe functionality
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Scribe')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Handwriting Recognition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.gesture, size: 48, color: Colors.cyan.shade700),
        SizedBox(height: 12),
        Text('Scribe System', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        Text('Apple Pencil to text conversion', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Feature('Text Fields', 'Automatic handwriting input'),
        _Feature('Placeholders', 'Visual feedback during writing'),
        _Feature('Selection', 'Edit and correct text'),
        _Feature('Toolbar', 'Additional editing options'),
      ]))),
    SizedBox(height: 8),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('iPadOS Scribble integration via ScribbleClient', style: TextStyle(fontSize: 10))),
  ])));
}

class _Feature extends StatelessWidget {
  final String name; final String desc;
  const _Feature(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Icon(Icons.check_circle, size: 16, color: Colors.cyan), SizedBox(width: 8), Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
