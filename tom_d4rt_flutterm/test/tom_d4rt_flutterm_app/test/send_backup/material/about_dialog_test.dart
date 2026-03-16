import 'package:flutter/material.dart';

/// Deep visual demo for AboutDialog widget.
/// Material dialog showing app information.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AboutDialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 12)]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.flutter_dash, color: Colors.blue, size: 32),
            ),
            const SizedBox(height: 12),
            const Text('My App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text('Version 1.0.0', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            const SizedBox(height: 12),
            const Text('© 2025 Company', style: TextStyle(fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('VIEW LICENSES', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.w500)),
                Text('CLOSE', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
