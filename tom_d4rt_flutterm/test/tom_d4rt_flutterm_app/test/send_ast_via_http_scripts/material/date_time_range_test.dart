import 'package:flutter/material.dart';

/// Deep visual demo for DateTimeRange - immutable time span container.
/// Shows start, end, and duration properties.
dynamic build(BuildContext context) {
  final range = DateTimeRange(
    start: DateTime(2024, 3, 10),
    end: DateTime(2024, 3, 17),
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DateTimeRange Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Start
            Column(
              children: [
                const Icon(Icons.play_arrow, color: Colors.teal),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Mar 10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const Text('start', style: TextStyle(fontSize: 10)),
              ],
            ),
            // Duration line
            Container(
              width: 80,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // End
            Column(
              children: [
                const Icon(Icons.stop, color: Colors.teal),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Mar 17', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const Text('end', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: Text('duration: ${range.duration.inDays} days', style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
      ),
    ],
  );
}
