import 'package:flutter/material.dart';

/// Deep visual demo for RenderIndexedStack
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('IndexedStack')), body: _IndexedStackDemo());
}

class _IndexedStackDemo extends StatefulWidget {
  @override State<_IndexedStackDemo> createState() => _IndexedStackDemoState();
}

class _IndexedStackDemoState extends State<_IndexedStackDemo> {
  int _index = 0;
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Single Visible Child', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: IndexedStack(index: _index, children: [
      Container(decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(12)), child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.home, size: 64, color: Colors.blue), Text('Home', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))]))),
      Container(decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(12)), child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.search, size: 64, color: Colors.orange), Text('Search', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))]))),
      Container(decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(12)), child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.settings, size: 64, color: Colors.green), Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))]))),
    ])),
    SizedBox(height: 12),
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      for (int i = 0; i < 3; i++) ElevatedButton(onPressed: () => setState(() => _index = i), child: Text('$i')),
    ]),
  ]));
}
