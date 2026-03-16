import 'package:flutter/material.dart';

/// Deep visual demo for SnackBarBehavior
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SnackBarBehavior Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fixed behavior'), behavior: SnackBarBehavior.fixed)), child: Text('Fixed SnackBar')), SizedBox(height: 20), ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Floating behavior'), behavior: SnackBarBehavior.floating, margin: EdgeInsets.all(16))), child: Text('Floating SnackBar'))])));
}
