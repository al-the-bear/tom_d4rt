import 'package:flutter/material.dart';

/// Deep visual demo for TappableChipAttributes
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TappableChipAttributes Demo')), body: Center(child: Wrap(spacing: 8, runSpacing: 8, children: [ActionChip(label: Text('Action'), onPressed: () {}), ActionChip(label: Text('With Avatar'), avatar: Icon(Icons.add, size: 18), onPressed: () {}), ActionChip(label: Text('Elevated'), onPressed: () {}, elevation: 4), ActionChip(label: Text('Custom Color'), onPressed: () {}, backgroundColor: Colors.blue.shade100), ActionChip(label: Text('Disabled'), onPressed: null), InputChip(label: Text('Input Chip'), onPressed: () {}, onDeleted: () {})])));
}
