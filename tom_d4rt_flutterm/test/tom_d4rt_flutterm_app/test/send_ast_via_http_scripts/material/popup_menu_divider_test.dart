import 'package:flutter/material.dart';

/// Deep visual demo for PopupMenuDivider widget.
/// Horizontal divider in popup menus.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PopupMenuDivider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 120,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(padding: EdgeInsets.all(12), child: Text('Edit', style: TextStyle(fontSize: 12))),
            Padding(padding: EdgeInsets.all(12), child: Text('Copy', style: TextStyle(fontSize: 12))),
            Divider(height: 1, thickness: 1, color: Colors.grey),
            Padding(padding: EdgeInsets.all(12), child: Text('Delete', style: TextStyle(fontSize: 12, color: Colors.red))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('height property adjusts spacing', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
