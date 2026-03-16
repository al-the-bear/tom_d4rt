import 'package:flutter/material.dart';

/// Deep visual demo for KeepAliveParentDataMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('KeepAlive Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Keep Alive Parent Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(children: [Icon(Icons.memory, color: Colors.green, size: 32), SizedBox(width: 12), Expanded(child: Text('Keeps children alive in lazy lists', style: TextStyle(fontSize: 14)))]),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            _KAItem(0, true), _KAItem(1, true), _KAItem(2, false), _KAItem(3, false),
          ])),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Mixin provides:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• keepAlive: bool - prevent disposal', style: TextStyle(fontSize: 11)),
        Text('• Used with AutomaticKeepAliveClientMixin', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
  ])));
}

class _KAItem extends StatelessWidget {
  final int index; final bool alive;
  const _KAItem(this.index, this.alive);
  @override Widget build(BuildContext context) => Expanded(child: Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: alive ? Colors.green : Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
    child: Column(children: [Text('$index', style: TextStyle(color: alive ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)), Icon(alive ? Icons.check : Icons.close, size: 12, color: alive ? Colors.white : Colors.grey)])));
}
