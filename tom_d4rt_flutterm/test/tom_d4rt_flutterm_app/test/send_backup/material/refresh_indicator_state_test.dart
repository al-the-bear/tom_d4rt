import 'package:flutter/material.dart';

/// Deep visual demo for RefreshIndicatorState.
/// State object providing programmatic refresh.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RefreshIndicatorState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('GlobalKey<RefreshIndicatorState>', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.refresh, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('.show()', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Trigger refresh programmatically', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
