import 'package:flutter/material.dart';

/// Deep visual demo for ChildSemanticsConfigurationsResult
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ConfigurationsResult')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Child Semantics Result', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.account_tree, size: 40, color: Colors.purple),
        SizedBox(height: 12),
        Text('Aggregated child configurations', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _ResultPart('Merged', Colors.blue),
          _ResultPart('Siblings', Colors.orange),
        ]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Contains:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• mergeUpConfigurations - configs to merge to parent', style: TextStyle(fontSize: 11)),
        Text('• siblingMergeGroups - grouped sibling configs', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _ResultPart extends StatelessWidget {
  final String label; final Color color;
  const _ResultPart(this.label, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)));
}
