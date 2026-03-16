import 'package:flutter/material.dart';

/// Deep visual demo for PerformanceOverlayLayer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Performance Overlay')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Performance Overlay Layer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _PerfBar('UI Thread', 0.7, Colors.green),
        SizedBox(height: 16),
        _PerfBar('Raster Thread', 0.4, Colors.blue),
        SizedBox(height: 16),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
          child: Text('Frame Budget: 16.67ms', style: TextStyle(color: Colors.white, fontFamily: 'monospace'))),
      ]))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Shows frame timing bars when enabled via PerformanceOverlay widget', style: TextStyle(fontSize: 11))),
  ])));
}

class _PerfBar extends StatelessWidget {
  final String name; final double value; final Color color;
  const _PerfBar(this.name, this.value, this.color);
  @override Widget build(BuildContext context) => Column(children: [
    Text(name, style: TextStyle(color: Colors.white, fontSize: 12)),
    SizedBox(height: 4),
    Container(width: 200, height: 20, decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
      child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: value, child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))))),
  ]);
}
