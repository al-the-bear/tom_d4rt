import 'package:flutter/material.dart';

/// Deep visual demo for FocusSemanticEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FocusSemanticEvent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green, width: 3)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.center_focus_strong, color: Colors.green, size: 32), SizedBox(width: 12), Text('Focused Element', style: TextStyle(fontWeight: FontWeight.bold))])),
    SizedBox(height: 24),
    Text('Focus Event', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _FocusState('Unfocused', Colors.grey, Icons.crop_free),
      Icon(Icons.arrow_forward, size: 32),
      _FocusState('Focused', Colors.green, Icons.center_focus_strong),
    ]),
    SizedBox(height: 24),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dispatched when:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Keyboard navigation focuses element', style: TextStyle(fontSize: 11)),
        Text('• Accessibility service requests focus', style: TextStyle(fontSize: 11)),
        Text('• programmatic focus change', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _FocusState extends StatelessWidget {
  final String label; final Color color; final IconData icon;
  const _FocusState(this.label, this.color, this.icon);
  @override Widget build(BuildContext context) => Column(children: [Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle), child: Icon(icon, color: color, size: 32)), SizedBox(height: 8), Text(label, style: TextStyle(fontWeight: FontWeight.bold))]);
}
