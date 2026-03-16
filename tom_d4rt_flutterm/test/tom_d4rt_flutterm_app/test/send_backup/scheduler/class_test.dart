import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Deep visual demo for scheduler package classes overview
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Scheduler Classes')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('flutter/scheduler.dart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace')),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _ClassTile('SchedulerBinding', 'Frame scheduling mixin', Colors.blue, true),
      _ClassTile('Ticker', 'Calls callback each frame', Colors.orange, false),
      _ClassTile('TickerFuture', 'Animation completion future', Colors.green, false),
      _ClassTile('TickerProvider', 'Creates Ticker instances', Colors.purple, true),
      _ClassTile('TickerProviderStateMixin', 'State mixin for Ticker', Colors.teal, true),
      Divider(),
      _ClassTile('Priority', 'Scheduling priority enum', Colors.red, false),
      _ClassTile('SchedulerPhase', 'Frame lifecycle phase', Colors.indigo, false),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('import "package:flutter/scheduler.dart"', style: TextStyle(fontFamily: 'monospace', fontSize: 11)))
  ])));
}

class _ClassTile extends StatelessWidget {
  final String name; final String desc; final Color color; final bool isMixin;
  const _ClassTile(this.name, this.desc, this.color, this.isMixin);
  @override Widget build(BuildContext context) => ListTile(
    leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(isMixin ? Icons.extension : Icons.class_, color: color, size: 20)),
    title: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), if (isMixin) Container(margin: EdgeInsets.only(left: 8), padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(4)), child: Text('mixin', style: TextStyle(color: Colors.white, fontSize: 9)))]),
    subtitle: Text(desc),
  );
}
