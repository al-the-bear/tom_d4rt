import 'package:flutter/material.dart';

/// Deep visual demo for ThemeData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ThemeData Demo')), body: Column(children: [Expanded(child: Theme(data: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true), child: Card(margin: EdgeInsets.all(16), child: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('Blue Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), ElevatedButton(onPressed: () {}, child: Text('Elevated')), TextButton(onPressed: () {}, child: Text('Text Button'))]))))), Expanded(child: Theme(data: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark), useMaterial3: true), child: Card(margin: EdgeInsets.all(16), child: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('Green Dark Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), ElevatedButton(onPressed: () {}, child: Text('Elevated')), TextButton(onPressed: () {}, child: Text('Text Button'))])))))]));
}
