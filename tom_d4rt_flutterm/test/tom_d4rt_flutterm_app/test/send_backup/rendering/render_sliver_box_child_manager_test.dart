import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverBoxChildManager
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Child Manager')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Child Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _ManagerStep('estimateMaxScrollOffset', 'Calculate max extent'),
        Icon(Icons.arrow_downward, color: Colors.indigo),
        _ManagerStep('createChild', 'Build visible child'),
        Icon(Icons.arrow_downward, color: Colors.indigo),
        _ManagerStep('removeChild', 'Recycle off-screen'),
        Icon(Icons.arrow_downward, color: Colors.indigo),
        _ManagerStep('didAdoptChild', 'Notify adoption'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Manages lazy child creation for SliverList/SliverGrid', style: TextStyle(fontSize: 11))),
  ])));
}

class _ManagerStep extends StatelessWidget {
  final String name; final String desc;
  const _ManagerStep(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
