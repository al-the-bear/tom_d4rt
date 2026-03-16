import 'package:flutter/material.dart';

/// Deep visual demo for Divider - thin horizontal line.
/// Shows various divider styles and configurations.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Divider Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default Divider:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            const Divider(),
            const SizedBox(height: 8),
            const Text('Thick Divider:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            const Divider(thickness: 4),
            const SizedBox(height: 8),
            const Text('Colored Divider:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.blue, thickness: 2),
            const SizedBox(height: 8),
            const Text('Indented Divider:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            const Divider(indent: 40, endIndent: 40),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('height = vertical space (default 16)', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
