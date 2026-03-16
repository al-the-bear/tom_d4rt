import 'package:flutter/material.dart';

/// Deep visual demo for SnackBar
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SnackBar Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Simple SnackBar'))), child: Text('Simple')), ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('With Action'), action: SnackBarAction(label: 'Undo', onPressed: () {}))), child: Text('With Action')), ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Floating'), behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))), child: Text('Floating Shaped'))])));
}
