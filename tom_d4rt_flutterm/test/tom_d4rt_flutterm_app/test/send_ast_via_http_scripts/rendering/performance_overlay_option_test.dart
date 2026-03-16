import 'package:flutter/material.dart';

/// Deep visual demo for PerformanceOverlayOption
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Perf Options')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Overlay Options', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _OptionCard('displayRasterizerStatistics', 'Raster thread stats', Colors.blue),
      _OptionCard('visualizeRasterizerStatistics', 'Frame bar chart', Colors.green),
      _OptionCard('displayEngineStatistics', 'Engine stats', Colors.orange),
      _OptionCard('visualizeEngineStatistics', 'Engine bar chart', Colors.purple),
    ])),
  ])));
}

class _OptionCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _OptionCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.speed, color: color), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'monospace')), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
