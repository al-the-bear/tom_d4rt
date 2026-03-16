import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for RawKeyEventData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('RawKeyEventData')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Raw Key Event Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: SingleChildScrollView(child: Column(children: [
      _Section('Base Class', 'RawKeyEventData is abstract base for platform key events', Icons.keyboard, Colors.blue),
      SizedBox(height: 12),
      _Section('Properties', 'keyLabel, logicalKey, physicalKey, modifiersPressed', Icons.list, Colors.green),
      SizedBox(height: 12),
      Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Platform Implementations:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          SizedBox(height: 8),
          _Platform('RawKeyEventDataAndroid', 'Android events'),
          _Platform('RawKeyEventDataFuchsia', 'Fuchsia events'),
          _Platform('RawKeyEventDataIos', 'iOS events'),
          _Platform('RawKeyEventDataMacOs', 'macOS events'),
          _Platform('RawKeyEventDataLinux', 'Linux/GTK events'),
          _Platform('RawKeyEventDataWindows', 'Windows events'),
          _Platform('RawKeyEventDataWeb', 'Web browser events'),
        ])),
      SizedBox(height: 12),
      _Section('Modifier Detection', 'isShiftPressed, isControlPressed, isAltPressed, isMetaPressed', Icons.tune, Colors.purple),
    ]))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Deprecated: Use KeyEvent and HardwareKeyboard instead', style: TextStyle(fontSize: 10, color: Colors.red))),
  ])));
}

class _Section extends StatelessWidget {
  final String title; final String desc; final IconData icon; final MaterialColor color;
  const _Section(this.title, this.desc, this.icon, this.color);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(icon, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}

class _Platform extends StatelessWidget {
  final String name; final String desc;
  const _Platform(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Icon(Icons.devices, size: 14, color: Colors.orange), SizedBox(width: 8), Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 9)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
