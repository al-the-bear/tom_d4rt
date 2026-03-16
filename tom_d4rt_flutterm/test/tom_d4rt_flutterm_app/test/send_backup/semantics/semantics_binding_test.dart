import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsBinding
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SemanticsBinding')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantics Binding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.link, size: 40, color: Colors.green),
        SizedBox(height: 8),
        Text('Platform ↔ Semantics', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Connects Flutter accessibility to native APIs', style: TextStyle(fontSize: 12)),
      ])),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _BindingFeature('Accessibility Features', 'Bold text, reduce motion, etc.', Icons.accessibility),
      _BindingFeature('Semantics Updates', 'Push tree changes to platform', Icons.publish),
      _BindingFeature('Platform Channels', 'Native accessibility bridge', Icons.phone_android),
      _BindingFeature('Debug Tools', 'Semantics tree debugging', Icons.bug_report),
    ])),
  ])));
}

class _BindingFeature extends StatelessWidget {
  final String title; final String desc; final IconData icon;
  const _BindingFeature(this.title, this.desc, this.icon);
  @override Widget build(BuildContext context) => ListTile(leading: Icon(icon, color: Colors.green), title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(desc));
}
