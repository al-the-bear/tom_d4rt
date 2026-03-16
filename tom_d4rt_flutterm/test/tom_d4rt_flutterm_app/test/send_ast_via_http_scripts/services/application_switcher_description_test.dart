import 'package:flutter/material.dart';

/// Deep visual demo for ApplicationSwitcherDescription
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('App Switcher')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('ApplicationSwitcherDescription', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(height: 150, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)]),
          child: Column(children: [
            Container(height: 30, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              child: Row(children: [SizedBox(width: 8), Icon(Icons.flutter_dash, color: Colors.white, size: 16), SizedBox(width: 4), Text('My App', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))])),
            Expanded(child: Container(color: Colors.grey.shade100, child: Center(child: Text('App Preview')))),
          ])),
        SizedBox(height: 16),
        _Field('label', 'App name in switcher'),
        _Field('primaryColor', 'Header bar color'),
      ])),
  ])));
}

class _Field extends StatelessWidget {
  final String name; final String desc;
  const _Field(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
