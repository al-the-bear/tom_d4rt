import 'package:flutter/material.dart';

/// Deep visual demo for AnnounceSemanticsEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AnnounceSemanticsEvent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.campaign, size: 60, color: Colors.orange),
    SizedBox(height: 8),
    Text('Announce Event', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('"Download complete!"', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
        SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.volume_up, color: Colors.orange), SizedBox(width: 8), Text('Screen reader speaks', style: TextStyle(color: Colors.grey))]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• message: String to announce', style: TextStyle(fontSize: 11)),
        Text('• textDirection: LTR or RTL', style: TextStyle(fontSize: 11)),
        Text('• assertiveness: polite/assertive', style: TextStyle(fontSize: 11)),
      ])),
    Spacer(),
    Text('Use for dynamic content updates', style: TextStyle(color: Colors.grey)),
  ])));
}
