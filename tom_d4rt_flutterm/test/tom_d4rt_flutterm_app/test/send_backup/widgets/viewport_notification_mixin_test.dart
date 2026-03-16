import 'package:flutter/material.dart';

/// Deep visual demo for ViewportNotificationMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ViewportNotification')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Viewport Notification Mixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.crop_free, size: 48, color: Colors.blueGrey),
        SizedBox(height: 12),
        Text('ViewportNotificationMixin', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Mixin for viewport-aware widgets', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Feature('notifyClients', 'Notify subscribed listeners'),
        _Feature('ViewportElementMixin', 'Element counterpart'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used for scroll notifications and viewport events', style: TextStyle(fontSize: 10))),
  ])));
}
class _Feature extends StatelessWidget {
  final String name; final String desc;
  const _Feature(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Icon(Icons.notifications, size: 14, color: Colors.blueGrey), SizedBox(width: 8), Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
