import 'package:flutter/material.dart';

/// Deep visual demo for Semantics label building
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SemanticsLabelBuilder')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.accessibility_new, size: 48, color: Colors.blue),
    SizedBox(height: 8),
    Text('Building Accessible Labels', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _LabelExample('Simple', 'Submit button', Icons.touch_app),
    _LabelExample('Compound', 'Step 1 of 5: Enter name', Icons.format_list_numbered),
    _LabelExample('Dynamic', 'Downloaded 45%', Icons.download),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Best Practices:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Be concise but descriptive', style: TextStyle(fontSize: 11)),
        Text('• Include state (selected, expanded)', style: TextStyle(fontSize: 11)),
        Text('• Avoid redundant info (icon names)', style: TextStyle(fontSize: 11)),
      ]))
  ])));
}

class _LabelExample extends StatelessWidget {
  final String type; final String label; final IconData icon;
  const _LabelExample(this.type, this.label, this.icon);
  @override Widget build(BuildContext context) => Card(child: ListTile(leading: Icon(icon, color: Colors.blue), title: Text(type, style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text('"$label"', style: TextStyle(fontStyle: FontStyle.italic))));
}
