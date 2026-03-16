import 'package:flutter/material.dart';

/// Deep visual demo for DatePickerMode - enum for date picker granularity.
/// Shows day view vs year view selection.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DatePickerMode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Day mode
          Container(
            width: 120,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green),
            ),
            child: Column(
              children: [
                const Text('day', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                const SizedBox(height: 8),
                // Mini calendar
                GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(7, (i) => Center(child: Text('${i + 1}', style: const TextStyle(fontSize: 8)))),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Year mode
          Container(
            width: 120,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange),
            ),
            child: Column(
              children: [
                const Text('year', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    Text('2022', style: TextStyle(fontSize: 10)),
                    Text('2023', style: TextStyle(fontSize: 10)),
                    Text('2024', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('2025', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('day: Select day | year: Select year first', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
