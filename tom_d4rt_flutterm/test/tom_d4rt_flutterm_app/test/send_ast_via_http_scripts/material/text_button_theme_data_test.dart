import 'package:flutter/material.dart';

/// Deep visual demo for TextButtonThemeData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextButtonThemeData Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [TextButton(onPressed: () {}, child: Text('Default TextButton')), SizedBox(height: 20), Theme(data: Theme.of(context).copyWith(textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.purple, backgroundColor: Colors.purple.shade50, padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16), textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))), child: TextButton(onPressed: () {}, child: Text('Themed TextButton'))), SizedBox(height: 20), Theme(data: Theme.of(context).copyWith(textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Colors.orange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))), child: TextButton(onPressed: () {}, child: Text('Rounded Theme')))])));
}
