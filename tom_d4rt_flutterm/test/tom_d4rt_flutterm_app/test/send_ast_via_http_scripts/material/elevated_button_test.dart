import 'package:flutter/material.dart';

/// Deep visual demo for ElevatedButton - Material elevated button.
/// Shows button with elevation, states, and customization.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ElevatedButton Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // Button states
      Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('Enabled')),
          const ElevatedButton(onPressed: null, child: Text('Disabled')),
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('With Icon')),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          children: [
            Text('Elevation: 1 → 3 on press', style: TextStyle(fontSize: 11)),
            Text('Use for primary actions', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    ],
  );
}
