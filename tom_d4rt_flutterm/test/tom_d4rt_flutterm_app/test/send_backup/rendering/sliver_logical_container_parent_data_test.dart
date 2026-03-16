import 'package:flutter/material.dart';

/// Deep visual demo for SliverLogicalContainerParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Logical Container')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverLogicalContainerParentData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lightGreen.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.account_tree, size: 48, color: Colors.lightGreen),
        SizedBox(height: 12),
        Text('Parent Data for Sliver Containers', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text('Used by SliverMainAxisGroup to position child slivers logically (in scrollable space)', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Extends ContainerParentDataMixin<RenderSliver>', style: TextStyle(fontFamily: 'monospace', fontSize: 9))),
  ])));
}
