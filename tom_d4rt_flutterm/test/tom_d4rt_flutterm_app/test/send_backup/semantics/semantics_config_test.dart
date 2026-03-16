import 'package:flutter/material.dart';

/// Deep visual demo for SemanticsConfiguration
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SemanticsConfiguration')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantics Configuration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _ConfigSection('Text Properties', [
        _ConfigProp('label', 'Accessibility label'),
        _ConfigProp('value', 'Current value'),
        _ConfigProp('hint', 'Usage hint'),
      ]),
      _ConfigSection('Boolean Flags', [
        _ConfigProp('isButton', 'Button semantics'),
        _ConfigProp('isHeader', 'Heading element'),
        _ConfigProp('isLink', 'Clickable link'),
        _ConfigProp('isSlider', 'Slider control'),
      ]),
      _ConfigSection('Actions', [
        _ConfigProp('onTap', 'Tap action'),
        _ConfigProp('onLongPress', 'Long press'),
        _ConfigProp('onScrollLeft', 'Scroll actions'),
      ]),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Mutable configuration for building SemanticsNode', style: TextStyle(fontSize: 11))),
  ])));
}

class _ConfigSection extends StatelessWidget {
  final String title; final List<_ConfigProp> props;
  const _ConfigSection(this.title, this.props);
  @override Widget build(BuildContext context) => Card(margin: EdgeInsets.only(bottom: 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(padding: EdgeInsets.all(8), color: Colors.green.withOpacity(0.1), child: Row(children: [Icon(Icons.settings, size: 16, color: Colors.green), SizedBox(width: 8), Text(title, style: TextStyle(fontWeight: FontWeight.bold))])),
    ...props,
  ]));
}

class _ConfigProp extends StatelessWidget {
  final String name; final String desc;
  const _ConfigProp(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 12)), Spacer(), Text(desc, style: TextStyle(color: Colors.grey, fontSize: 11))]));
}
