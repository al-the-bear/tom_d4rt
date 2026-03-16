import 'package:flutter/material.dart';

/// Deep visual demo for Divider used with ListTile - visual separators.
/// Shows how dividers separate list items.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Divider with ListTiles', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.inbox, color: Colors.blue),
              title: Text('Inbox'),
              trailing: Text('12'),
              dense: true,
            ),
            const Divider(height: 1, indent: 56),
            const ListTile(
              leading: Icon(Icons.send, color: Colors.blue),
              title: Text('Sent'),
              trailing: Text('5'),
              dense: true,
            ),
            const Divider(height: 1, indent: 56),
            const ListTile(
              leading: Icon(Icons.drafts, color: Colors.blue),
              title: Text('Drafts'),
              trailing: Text('2'),
              dense: true,
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('indent: 56 aligns with leading icon', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
