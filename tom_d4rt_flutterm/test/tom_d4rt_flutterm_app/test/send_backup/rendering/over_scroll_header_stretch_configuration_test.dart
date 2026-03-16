import 'package:flutter/material.dart';

/// Deep visual demo for over scroll header stretch configuration
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverAppBar(title: Text('OverScroll Stretch'), expandedHeight: 200, stretch: true, stretchTriggerOffset: 100,
      onStretchTrigger: () async => print('Stretched!'),
      flexibleSpace: FlexibleSpaceBar(background: Container(color: Colors.blue.shade200, child: Center(child: Text('Pull down to stretch', style: TextStyle(fontSize: 24, color: Colors.white)))))),
    SliverToBoxAdapter(child: Container(padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Configuration Options', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 12),
        _ConfigItem('stretchTriggerOffset', '100.0'),
        _ConfigItem('onStretchTrigger', 'Callback'),
      ]))),
    SliverList(delegate: SliverChildBuilderDelegate((_, i) => ListTile(title: Text('Item $i')), childCount: 20)),
  ]));
}

class _ConfigItem extends StatelessWidget {
  final String name; final String value;
  const _ConfigItem(this.name, this.value);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace')), Spacer(), Text(value, style: TextStyle(color: Colors.grey))]));
}
