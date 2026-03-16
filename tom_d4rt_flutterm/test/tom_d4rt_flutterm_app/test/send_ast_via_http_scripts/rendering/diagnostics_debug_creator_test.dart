import 'package:flutter/material.dart';

/// Deep visual demo for diagnostic debug creator
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('DiagnosticsDebugCreator')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.bug_report, size: 48, color: Colors.green),
    SizedBox(height: 8),
    Text('Debug Creator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Widget → Render Object Tracking', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _TrackRow('Widget', 'MyButton'),
        Icon(Icons.arrow_downward, color: Colors.grey),
        _TrackRow('Element', 'StatefulElement'),
        Icon(Icons.arrow_downward, color: Colors.grey),
        _TrackRow('RenderObject', 'RenderDecoratedBox'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Links render objects back to their creating widgets for debugging', style: TextStyle(fontSize: 12))),
  ])));
}

class _TrackRow extends StatelessWidget {
  final String type; final String name;
  const _TrackRow(this.type, this.name);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(type, style: TextStyle(fontSize: 10))), SizedBox(width: 8), Text(name, style: TextStyle(fontFamily: 'monospace'))]));
}
