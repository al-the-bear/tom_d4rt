import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Deep visual demo for SchedulerPhase enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SchedulerPhase')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Frame Lifecycle Phases', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _PhaseCard(SchedulerPhase.idle, 'Idle', 'No frame in progress', Colors.grey, 1),
      Icon(Icons.arrow_downward, color: Colors.grey),
      _PhaseCard(SchedulerPhase.transientCallbacks, 'Transient', 'Animations tick', Colors.blue, 2),
      Icon(Icons.arrow_downward, color: Colors.grey),
      _PhaseCard(SchedulerPhase.midFrameMicrotasks, 'Microtasks', 'Post-animation work', Colors.purple, 3),
      Icon(Icons.arrow_downward, color: Colors.grey),
      _PhaseCard(SchedulerPhase.persistentCallbacks, 'Persistent', 'Build & layout', Colors.orange, 4),
      Icon(Icons.arrow_downward, color: Colors.grey),
      _PhaseCard(SchedulerPhase.postFrameCallbacks, 'Post-frame', 'After rendering', Colors.green, 5),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Access via SchedulerBinding.instance.schedulerPhase', style: TextStyle(fontSize: 11, fontFamily: 'monospace')))
  ])));
}

class _PhaseCard extends StatelessWidget {
  final SchedulerPhase phase; final String name; final String desc; final Color color; final int order;
  const _PhaseCard(this.phase, this.name, this.desc, this.color, this.order);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
    child: Row(children: [CircleAvatar(backgroundColor: color, radius: 14, child: Text('$order', style: TextStyle(color: Colors.white, fontSize: 12))), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 11))]))]));
}
