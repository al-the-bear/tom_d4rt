import 'package:flutter/material.dart';

/// Demonstrates AnimationLocalListenersMixin - manages value change listeners.
/// Provides addListener(), removeListener(), notifyListeners(), clearListeners().
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimationLocalListenersMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Value Listeners', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            // Visual: Animation with multiple listeners
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.animation, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    for (int i = 1; i <= 3; i++)
                      Row(
                        children: [
                          const Icon(Icons.arrow_forward, size: 16, color: Colors.blue),
                          Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)),
                            child: Text('Listener $i', style: const TextStyle(fontSize: 10)),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('API:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('• addListener(VoidCallback)', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
            Text('• removeListener(VoidCallback)', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
            Text('• notifyListeners()', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
          ],
        ),
      ),
    ],
  );
}
