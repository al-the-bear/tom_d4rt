import 'package:flutter/material.dart';

/// Deep visual demo for ContextMenuButtonItem
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Context Button')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ContextMenuButtonItem', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _MenuItem('Cut', Icons.cut),
        Divider(height: 1),
        _MenuItem('Copy', Icons.copy),
        Divider(height: 1),
        _MenuItem('Paste', Icons.paste),
        Divider(height: 1),
        _MenuItem('Select All', Icons.select_all),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Individual item in context menu', style: TextStyle(fontSize: 11))),
  ])));
}

class _MenuItem extends StatelessWidget {
  final String name; final IconData icon;
  const _MenuItem(this.name, this.icon);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Row(children: [Icon(icon, size: 18, color: Colors.grey), SizedBox(width: 12), Text(name)]));
}
