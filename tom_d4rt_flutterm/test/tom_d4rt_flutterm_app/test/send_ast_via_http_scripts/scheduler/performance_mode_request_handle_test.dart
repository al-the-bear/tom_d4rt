import 'package:flutter/material.dart';

/// Deep visual demo for PerformanceModeRequestHandle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PerformanceModeRequestHandle')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.speed, size: 60, color: Colors.red),
    SizedBox(height: 16),
    Text('Performance Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    Text('Request Handle', style: TextStyle(color: Colors.grey)),
    SizedBox(height: 24),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _ModeCol(Icons.battery_full, 'Normal', 'Balanced'),
          Icon(Icons.arrow_forward),
          _ModeCol(Icons.flash_on, 'Performance', 'Max FPS'),
        ]),
        SizedBox(height: 16),
        Text('Requests high-performance mode from platform', style: TextStyle(fontSize: 12)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('final handle = SchedulerBinding', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
        Text('    .instance.requestPerformanceMode();', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
        Text('// ... high-performance work ...', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Colors.grey)),
        Text('handle.dispose();', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
      ]))
  ])));
}

class _ModeCol extends StatelessWidget {
  final IconData icon; final String name; final String desc;
  const _ModeCol(this.icon, this.name, this.desc);
  @override Widget build(BuildContext context) => Column(children: [Icon(icon, size: 32, color: Colors.red), Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 10))]);
}
