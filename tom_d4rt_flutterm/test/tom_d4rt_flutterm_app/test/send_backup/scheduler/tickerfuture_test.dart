import 'package:flutter/material.dart';

/// Deep visual demo for TickerFuture
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TickerFuture')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.timer, size: 60, color: Colors.blue),
    SizedBox(height: 16),
    Text('TickerFuture', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    SizedBox(height: 8),
    Text('Future that completes when animation ends', style: TextStyle(color: Colors.grey)),
    SizedBox(height: 24),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Completion States', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _StateRow(Icons.check_circle, 'orCancel', 'Completes or cancels gracefully', Colors.green),
        _StateRow(Icons.cancel, 'whenCompleteOrCancel', 'Callback for either outcome', Colors.orange),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('final future = controller.forward();', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
        Text('await future.orCancel;', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
      ]))
  ])));
}

class _StateRow extends StatelessWidget {
  final IconData icon; final String name; final String desc; final Color color;
  const _StateRow(this.icon, this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [Icon(icon, color: color, size: 20), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 11))]))]));
}
