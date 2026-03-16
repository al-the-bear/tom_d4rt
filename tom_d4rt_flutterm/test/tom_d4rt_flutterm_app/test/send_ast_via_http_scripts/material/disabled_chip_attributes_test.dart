import 'package:flutter/material.dart';

/// Deep visual demo for DisabledChipAttributes - interface for disabled chips.
/// Shows disabled visual style and isEnabled property.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DisabledChipAttributes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Enabled
          Column(
            children: [
              const ActionChip(
                label: Text('Enabled'),
                onPressed: null,
                avatar: Icon(Icons.check_circle, color: Colors.green, size: 18),
              ),
              const SizedBox(height: 4),
              const Text('isEnabled: true', style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(width: 16),
          // Disabled
          Column(
            children: [
              ActionChip(
                label: const Text('Disabled'),
                onPressed: null,
                avatar: const Icon(Icons.block, size: 18),
                disabledColor: Colors.grey.shade300,
              ),
              const SizedBox(height: 4),
              const Text('isEnabled: false', style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
            ],
          ),
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
            Text('Disabled Look:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            Text('• Reduced opacity', style: TextStyle(fontSize: 10)),
            Text('• Grey colors', style: TextStyle(fontSize: 10)),
            Text('• No interaction', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    ],
  );
}
