import 'package:flutter/material.dart';

/// Deep visual demo for AnnotationResult
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AnnotationResult')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Annotation Search Result', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.search, size: 40, color: Colors.teal),
        SizedBox(height: 8),
        Text('Hit Test at Point', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text('Entry 1')),
          SizedBox(width: 8),
          Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text('Entry 2')),
          SizedBox(width: 8),
          Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text('Entry 3')),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('AnnotationResult<T> properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• entries: Iterable<AnnotationEntry<T>>', style: TextStyle(fontSize: 11)),
        Text('Returns all annotations at hit position', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
  ])));
}
