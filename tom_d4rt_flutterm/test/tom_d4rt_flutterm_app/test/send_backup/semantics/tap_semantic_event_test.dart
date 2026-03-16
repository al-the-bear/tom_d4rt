import 'package:flutter/material.dart';

/// Deep visual demo for TapSemanticEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TapSemanticEvent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    GestureDetector(onTap: () {},
      child: Container(padding: EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.touch_app, color: Colors.white, size: 32), SizedBox(width: 12), Text('Tap Me!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))]))),
    SizedBox(height: 24),
    Text('Tap Semantics Event', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _StepRow('1', 'User taps element', Icons.touch_app),
        _StepRow('2', 'TapSemanticEvent dispatched', Icons.send),
        _StepRow('3', 'Accessibility service notified', Icons.accessibility),
      ])),
    Spacer(),
    Text('Primary interaction event for buttons and interactive elements', style: TextStyle(fontSize: 12, color: Colors.grey)),
  ])));
}

class _StepRow extends StatelessWidget {
  final String num; final String text; final IconData icon;
  const _StepRow(this.num, this.text, this.icon);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(children: [CircleAvatar(radius: 14, backgroundColor: Colors.blue, child: Text(num, style: TextStyle(color: Colors.white, fontSize: 12))), SizedBox(width: 12), Icon(icon, color: Colors.blue), SizedBox(width: 8), Text(text)]));
}
