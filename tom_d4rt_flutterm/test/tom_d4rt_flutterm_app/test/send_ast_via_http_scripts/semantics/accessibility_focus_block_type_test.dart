import 'package:flutter/material.dart';

/// Deep visual demo for accessibility focus blocking types
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Focus Block Types')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Accessibility Focus Blocking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _BlockCard('None', 'Normal focus behavior', Icons.crop_free, Colors.green),
    SizedBox(height: 8),
    _BlockCard('Block Descendants', 'Children not focusable', Icons.block, Colors.orange),
    SizedBox(height: 8),
    _BlockCard('Block All', 'Entire subtree blocked', Icons.do_not_disturb, Colors.red),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text('Use Cases:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Loading overlays', style: TextStyle(fontSize: 11)),
        Text('• Modal dialogs (block background)', style: TextStyle(fontSize: 11)),
        Text('• Disabled sections', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _BlockCard extends StatelessWidget {
  final String name; final String desc; final IconData icon; final Color color;
  const _BlockCard(this.name, this.desc, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Row(children: [Icon(icon, color: color, size: 32), SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 12))]))]));
}
