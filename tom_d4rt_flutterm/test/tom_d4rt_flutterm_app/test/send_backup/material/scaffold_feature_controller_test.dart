import 'package:flutter/material.dart';

/// Deep visual demo for ScaffoldFeatureController.
/// Controls scaffold features like bottom sheets.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ScaffoldFeatureController', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('ScaffoldFeatureController<T, U>', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: const [
                      Icon(Icons.minimize, color: Colors.blue),
                      Text('.close()', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: const [
                      Icon(Icons.visibility, color: Colors.green),
                      Text('.setState()', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Text('closed: Future<U>', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Returned from showBottomSheet()', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
