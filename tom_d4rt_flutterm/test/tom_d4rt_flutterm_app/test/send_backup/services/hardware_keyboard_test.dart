import 'package:flutter/material.dart';

/// Deep visual demo for HardwareKeyboard
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Hardware Keyboard')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('HardwareKeyboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.keyboard, size: 48, color: Colors.deepPurple),
        SizedBox(height: 12),
        _Method('physicalKeysPressed', 'Set of pressed keys'),
        _Method('logicalKeysPressed', 'Logical keys pressed'),
        _Method('lockModesEnabled', 'CapsLock, NumLock etc'),
        _Method('addHandler', 'Listen to key events'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('HardwareKeyboard.instance.physicalKeysPressed', style: TextStyle(fontFamily: 'monospace', fontSize: 9))),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
