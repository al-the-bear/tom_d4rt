import 'package:flutter/material.dart';

/// Deep visual demo for RenderMetaData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MetaData')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Render Metadata', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    MetaData(metaData: {'key': 'my-widget', 'version': '1.0'},
      child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.deepOrange)),
        child: Column(children: [
          Icon(Icons.data_object, size: 48, color: Colors.deepOrange),
          SizedBox(height: 8),
          Text('Widget with metadata', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(margin: EdgeInsets.only(top: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Text("metaData: {'key': 'my-widget'}", style: TextStyle(fontFamily: 'monospace', fontSize: 10))),
        ]))),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Attaches arbitrary data to render objects for debugging', style: TextStyle(fontSize: 11))),
  ])));
}
