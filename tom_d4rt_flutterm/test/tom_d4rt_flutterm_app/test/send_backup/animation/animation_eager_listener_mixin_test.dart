import 'package:flutter/material.dart';

/// Demonstrates AnimationEagerListenerMixin - notifies listeners immediately
/// upon registration, ensuring they receive the current value right away.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimationEagerListenerMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Icon(Icons.bolt, color: Colors.amber, size: 40),
            const SizedBox(height: 8),
            const Text('EAGER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amber)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Column(
                children: [
                  Icon(Icons.person_add, color: Colors.amber),
                  Icon(Icons.arrow_downward, size: 16),
                  Icon(Icons.notifications_active, color: Colors.amber),
                  Text('Notifies IMMEDIATELY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
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
            Text('Use when:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('• Listeners need current value on subscribe', style: TextStyle(fontSize: 11)),
            Text('• Animation state must be synchronized', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    ],
  );
}
