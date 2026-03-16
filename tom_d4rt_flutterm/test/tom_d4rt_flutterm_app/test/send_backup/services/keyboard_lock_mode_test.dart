import 'package:flutter/material.dart';

/// Deep visual demo for KeyboardLockMode
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Lock Modes')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('KeyboardLockMode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _LockCard('numLock', 'Numeric keypad mode', Colors.blue, Icons.numbers),
    _LockCard('capsLock', 'Capital letters mode', Colors.green, Icons.text_fields),
    _LockCard('scrollLock', 'Scroll behavior mode', Colors.orange, Icons.swap_vert),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('HardwareKeyboard.instance.lockModesEnabled', style: TextStyle(fontFamily: 'monospace', fontSize: 9))),
  ])));
}

class _LockCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final IconData icon;
  const _LockCard(this.name, this.desc, this.color, this.icon);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Row(children: [
      Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: color.shade200, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color.shade700, size: 24)),
      SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 14)), Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey))])),
    ]));
}
