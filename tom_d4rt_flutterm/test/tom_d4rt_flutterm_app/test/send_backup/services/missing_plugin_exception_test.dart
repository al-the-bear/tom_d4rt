import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for MissingPluginException
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MissingPluginException')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Plugin Not Found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.shade200)),
      child: Column(children: [
        Icon(Icons.extension_off, size: 48, color: Colors.red),
        SizedBox(height: 12),
        Text('MissingPluginException', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        Text('Thrown when platform plugin is unavailable', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Common Causes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        SizedBox(height: 8),
        _Cause('Plugin not added', 'pubspec.yaml missing dependency'),
        _Cause('Platform not supported', 'Plugin unavailable on this platform'),
        _Cause('Hot restart issue', 'Try full restart of app'),
        _Cause('Channel not registered', 'Native code not initialized'),
        SizedBox(height: 12),
        Text('Constructor:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        Text("MissingPluginException('channel.name')", style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
      ]))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Handle gracefully with fallback behavior', style: TextStyle(fontSize: 10))),
  ])));
}

class _Cause extends StatelessWidget {
  final String title; final String desc;
  const _Cause(this.title, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 6),
    child: Row(children: [Icon(Icons.warning_amber, size: 16, color: Colors.orange), SizedBox(width: 8), Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), Spacer(), Expanded(child: Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey), textAlign: TextAlign.right))]));
}
