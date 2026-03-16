import 'package:flutter/material.dart';

/// Deep visual demo for TooltipSemanticsEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TooltipSemanticsEvent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Tooltip(message: 'Example tooltip!', child: Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.teal.shade100, borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.info, color: Colors.teal), SizedBox(width: 8), Text('Hover/Long press me')]))),
    SizedBox(height: 24),
    Text('Tooltip Semantics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(children: [Icon(Icons.campaign, color: Colors.teal), SizedBox(width: 12), Text('Announces tooltip to screen reader', style: TextStyle(fontWeight: FontWeight.bold))]),
        Divider(),
        Row(children: [Icon(Icons.message, color: Colors.teal), SizedBox(width: 12), Expanded(child: Text('message: The tooltip text content'))]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Fired when tooltip becomes visible', style: TextStyle(fontSize: 12, color: Colors.orange.shade800))),
  ])));
}
