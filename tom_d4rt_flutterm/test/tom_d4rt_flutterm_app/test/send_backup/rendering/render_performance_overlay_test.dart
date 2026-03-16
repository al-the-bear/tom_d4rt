import 'package:flutter/material.dart';

/// Deep visual demo for RenderPerformanceOverlay
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Performance Overlay')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Performance Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _MetricBar('UI Thread', 0.4, Colors.blue),
        SizedBox(height: 8),
        _MetricBar('Raster Thread', 0.6, Colors.green),
        SizedBox(height: 12),
        Row(children: [_Legend(Colors.green, 'Good'), SizedBox(width: 12), _Legend(Colors.yellow, 'Slow'), SizedBox(width: 12), _Legend(Colors.red, 'Janky')]),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Shows:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Frame timing graphs', style: TextStyle(fontSize: 11)),
        Text('• UI and raster thread load', style: TextStyle(fontSize: 11)),
        Text('• 16ms target line', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _MetricBar extends StatelessWidget {
  final String label; final double value; final Color color;
  const _MetricBar(this.label, this.value, this.color);
  @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: TextStyle(color: Colors.white70, fontSize: 11)),
    SizedBox(height: 4),
    Container(height: 20, decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
      child: FractionallySizedBox(widthFactor: value, child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))))),
  ]);
}

Widget _Legend(Color c, String t) => Row(children: [Container(width: 12, height: 12, color: c), SizedBox(width: 4), Text(t, style: TextStyle(color: Colors.white70, fontSize: 10))]);
