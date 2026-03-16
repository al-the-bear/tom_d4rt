import 'package:flutter/material.dart';

/// Deep visual demo for rendering constants
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Rendering Constants')), body: Padding(padding: EdgeInsets.all(16), child: ListView(children: [
    Text('Rendering Constants', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _ConstCard('kDefaultCacheExtent', '250.0', 'Viewport pre-render pixels'),
    _ConstCard('kMinInteractiveDimension', '48.0', 'Touch target minimum'),
    _ConstCard('kToolbarHeight', '56.0', 'AppBar height'),
    _ConstCard('kBottomNavigationBarHeight', '56.0', 'Bottom nav height'),
    _ConstCard('kTextTabBarHeight', '48.0', 'TabBar height'),
    _ConstCard('kFloatingActionButtonMargin', '16.0', 'FAB margin'),
    Divider(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Material Design standard measurements', style: TextStyle(fontSize: 11))),
  ])));
}

class _ConstCard extends StatelessWidget {
  final String name; final String value; final String desc;
  const _ConstCard(this.name, this.value, this.desc);
  @override Widget build(BuildContext context) => Card(child: ListTile(
    title: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
    subtitle: Text(desc),
    trailing: Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(4)),
      child: Text(value, style: TextStyle(fontWeight: FontWeight.bold)))));
}
