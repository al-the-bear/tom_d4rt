import 'package:flutter/material.dart';

/// Deep visual demo for DayPeriod - enum for AM/PM in time pickers.
/// Shows how day periods partition the 24-hour clock.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DayPeriod Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // AM
          Container(
            width: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber),
            ),
            child: const Column(
              children: [
                Icon(Icons.wb_sunny, color: Colors.amber, size: 32),
                SizedBox(height: 8),
                Text('AM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('12:00 - 11:59', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // PM
          Container(
            width: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.indigo),
            ),
            child: const Column(
              children: [
                Icon(Icons.nightlight_round, color: Colors.indigo, size: 32),
                SizedBox(height: 8),
                Text('PM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('12:00 - 11:59', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Used in TimeOfDay and time pickers', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
