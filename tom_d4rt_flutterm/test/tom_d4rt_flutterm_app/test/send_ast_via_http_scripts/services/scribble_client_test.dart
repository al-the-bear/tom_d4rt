import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

/// Deep visual demo for ScribbleClient
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ScribbleClient')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('iPad Scribble Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.draw, size: 48, color: Colors.indigo),
        SizedBox(height: 12),
        Text('ScribbleClient Interface', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _Method('currentTextEditingValue', 'Get current text'),
        _Method('insertTextPlaceholder', 'Reserve space for handwriting'),
        _Method('removeTextPlaceholder', 'Remove placeholder'),
        _Method('performSelector', 'Execute selector command'),
        _Method('showToolbar', 'Show editing toolbar'),
        _Method('isInScribbleRect', 'Check if rect is in bounds'),
        _Method('bounds', 'Client bounds rectangle'),
        _Method('elementIdentifier', 'Unique element ID'),
        _Method('onScribbleFocus', 'Handle scribble focus'),
      ]))),
    SizedBox(height: 8),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('iPadOS Apple Pencil handwriting input', style: TextStyle(fontSize: 10))),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.indigo.shade700)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
