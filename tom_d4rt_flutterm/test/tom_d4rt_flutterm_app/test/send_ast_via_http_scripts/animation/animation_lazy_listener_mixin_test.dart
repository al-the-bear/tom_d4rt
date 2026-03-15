import 'package:flutter/material.dart';

/// Demonstrates AnimationLazyListenerMixin - starts/stops animation resources
/// only when listeners are present, conserving resources.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimationLazyListenerMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Icon(Icons.eco, color: Colors.green, size: 40),
            const SizedBox(height: 8),
            const Text('LAZY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green)),
            const SizedBox(height: 12),
            // Lifecycle
            for (final step in ['No listeners → idle', '+Listener → didStartListening()', '-Last → didStopListening()'])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                  child: Text(step, style: const TextStyle(fontSize: 10)),
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: const Column(
          children: [
            Text('Benefit:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Resources only consumed when observed', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    ],
  );
}
