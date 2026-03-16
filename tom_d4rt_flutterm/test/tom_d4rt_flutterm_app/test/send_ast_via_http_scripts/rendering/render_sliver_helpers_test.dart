import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverHelpers
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Helpers')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Helper Methods', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _HelperCard('childScrollOffset', 'Get child scroll position'),
      _HelperCard('childMainAxisPosition', 'Child position on main axis'),
      _HelperCard('childCrossAxisPosition', 'Child position on cross axis'),
      _HelperCard('calculatePaintOffset', 'Compute paint offset'),
      _HelperCard('calculateCacheOffset', 'Compute cache offset'),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Helper methods for sliver layout calculations', style: TextStyle(fontSize: 11))),
  ])));
}

class _HelperCard extends StatelessWidget {
  final String name; final String desc;
  const _HelperCard(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.functions, color: Colors.blue), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
