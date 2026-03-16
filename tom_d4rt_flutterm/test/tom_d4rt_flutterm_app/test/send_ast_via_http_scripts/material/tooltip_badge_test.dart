import 'package:flutter/material.dart';

/// Deep visual demo for TooltipBadge
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Tooltip with Badge Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Tooltip(message: 'Notifications (3 unread)', child: Badge(label: Text('3'), child: IconButton(icon: Icon(Icons.notifications, size: 32), onPressed: () {}))), SizedBox(height: 30), Tooltip(message: 'Messages', child: Badge.count(count: 12, child: IconButton(icon: Icon(Icons.mail, size: 32), onPressed: () {}))), SizedBox(height: 30), Tooltip(message: 'Shopping Cart', child: Badge(label: Text('5'), backgroundColor: Colors.green, child: IconButton(icon: Icon(Icons.shopping_cart, size: 32), onPressed: () {})))])));
}
