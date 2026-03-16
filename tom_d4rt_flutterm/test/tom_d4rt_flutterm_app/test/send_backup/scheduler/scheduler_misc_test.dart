import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Deep visual demo for Scheduler miscellaneous utilities
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Scheduler Utilities')), body: Padding(padding: EdgeInsets.all(16), child: ListView(children: [
    Text('Scheduler Utilities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _UtilCard('timeDilation', 'Slow down animations', Icons.slow_motion_video, 'timeDilation = 2.0 (half speed)'),
    _UtilCard('debugPrintBeginFrameBanner', 'Debug frame start', Icons.bug_report, 'Print frame begin info'),
    _UtilCard('debugPrintEndFrameBanner', 'Debug frame end', Icons.bug_report, 'Print frame end info'),
    _UtilCard('debugCurrentCallbackIdentifier', 'Identify callbacks', Icons.fingerprint, 'Track callback source'),
    Divider(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Frame Callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• addTimingsCallback', style: TextStyle(fontSize: 11)),
        Text('• addPersistentFrameCallback', style: TextStyle(fontSize: 11)),
        Text('• addPostFrameCallback', style: TextStyle(fontSize: 11)),
        Text('• scheduleFrameCallback', style: TextStyle(fontSize: 11)),
      ]))
  ])));
}

class _UtilCard extends StatelessWidget {
  final String name; final String desc; final IconData icon; final String detail;
  const _UtilCard(this.name, this.desc, this.icon, this.detail);
  @override Widget build(BuildContext context) => Card(child: ListTile(leading: Icon(icon, color: Colors.blue), title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')), subtitle: Text(desc), trailing: IconButton(icon: Icon(Icons.info_outline), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(detail))))));
}
