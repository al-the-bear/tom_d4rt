import 'package:flutter/material.dart';

/// Deep visual demo for ChildLayoutHelper utilities
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ChildLayoutHelper')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Layout Helper Utilities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _HelperCard('dryLayoutChild', 'Measure without side effects', Colors.blue),
    SizedBox(height: 8),
    _HelperCard('layoutChild', 'Perform actual layout', Colors.green),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Used in RenderBox for:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Intrinsic size calculations', style: TextStyle(fontSize: 11)),
        Text('• Dry layout (computeDryLayout)', style: TextStyle(fontSize: 11)),
        Text('• Actual layout (performLayout)', style: TextStyle(fontSize: 11)),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Dry layout enables efficient intrinsic measurements', style: TextStyle(fontSize: 11))),
  ])));
}

class _HelperCard extends StatelessWidget {
  final String name; final String desc; final Color color;
  const _HelperCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Row(children: [Icon(Icons.build, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')), Text(desc, style: TextStyle(fontSize: 11))]))]));
}
