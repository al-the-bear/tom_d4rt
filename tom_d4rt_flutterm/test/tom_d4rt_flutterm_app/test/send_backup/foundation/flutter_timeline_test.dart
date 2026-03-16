import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for FlutterTimeline - timeline event tracking.
/// Shows how frame timing events are recorded for profiling.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FlutterTimeline Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timeline Event Visualization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 200,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Frame Timeline (16ms target)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 12),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _TimelineBar(label: 'Build', ms: 4, color: Colors.blue),
                      _TimelineBar(label: 'Layout', ms: 3, color: Colors.green),
                      _TimelineBar(label: 'Paint', ms: 5, color: Colors.orange),
                      _TimelineBar(label: 'Comp', ms: 2, color: Colors.purple),
                      _TimelineBar(label: 'Raster', ms: 6, color: Colors.red),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.red.withValues(alpha: 0.5),
                  margin: const EdgeInsets.only(top: 4),
                ),
                const Text('16ms budget', style: TextStyle(fontSize: 10, color: Colors.red)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('API:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('FlutterTimeline.startSync("name")', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('FlutterTimeline.finishSync()', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TimelineBar extends StatelessWidget {
  final String label;
  final int ms;
  final Color color;
  const _TimelineBar({required this.label, required this.ms, required this.color});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('\${ms}ms', style: TextStyle(fontSize: 9, color: color)),
            Container(
              height: ms * 8.0,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 9)),
          ],
        ),
      ),
    );
  }
}
