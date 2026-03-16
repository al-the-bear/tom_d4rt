import 'package:flutter/material.dart';

/// Deep visual demo for ListBody parent data
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ListBody Data')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('List Body Parent Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: ListBody(children: [
        _ListItem(0, Colors.green),
        _ListItem(1, Colors.green.shade300),
        _ListItem(2, Colors.green.shade200),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('ListBodyParentData:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Extends BoxParentData', style: TextStyle(fontSize: 11)),
        Text('• Contains offset for positioning', style: TextStyle(fontSize: 11)),
        Text('• Used by RenderListBody', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _ListItem extends StatelessWidget {
  final int index; final Color color;
  const _ListItem(this.index, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
    child: Row(children: [CircleAvatar(radius: 12, backgroundColor: color, child: Text('$index', style: TextStyle(color: Colors.white, fontSize: 11))), SizedBox(width: 12), Text('Item $index', style: TextStyle(fontWeight: FontWeight.bold))]));
}
