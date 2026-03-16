import 'package:flutter/material.dart';

/// Demonstrates ProxyAnimation - forwards to another animation (used in compounds).
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ProxyAnimation Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // Show proxy concept
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Consumer', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: Colors.indigo),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.indigo.shade700, width: 2)),
                  child: const Text('Proxy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: Colors.indigo),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Real', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('ProxyAnimation.parent can be swapped at runtime', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Wraps another animation for indirection', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
