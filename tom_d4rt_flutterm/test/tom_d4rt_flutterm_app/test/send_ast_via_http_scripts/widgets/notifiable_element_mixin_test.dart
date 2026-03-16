import 'package:flutter/material.dart';

/// Deep visual demo for NotifiableElementMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('NotifiableElement')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Notifiable Element Mixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.notifications_active, size: 48, color: Colors.amber.shade700),
        SizedBox(height: 12),
        Text('Element Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Mixin for notification-aware elements', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Feature('attachNotificationTree', 'Attach to tree'),
        _Feature('detachNotificationTree', 'Detach from tree'),
        _Feature('onNotification', 'Handle notifications'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by InheritedNotifier and similar widgets', style: TextStyle(fontSize: 10))),
  ])));
}
class _Feature extends StatelessWidget {
  final String name; final String desc;
  const _Feature(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Icon(Icons.check, size: 14, color: Colors.amber), SizedBox(width: 8), Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
