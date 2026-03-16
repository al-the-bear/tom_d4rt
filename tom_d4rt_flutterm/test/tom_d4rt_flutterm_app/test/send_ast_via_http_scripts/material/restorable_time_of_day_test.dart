import 'package:flutter/material.dart';

/// Deep visual demo for RestorableTimeOfDay class.
/// TimeOfDay that can be restored across app restarts.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RestorableTimeOfDay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Icon(Icons.restore, color: Colors.orange, size: 32),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Text('10:30 AM', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            const Text('Persisted across restarts', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('RestorationMixin integration', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
