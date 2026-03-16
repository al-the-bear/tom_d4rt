import 'package:flutter/material.dart';

/// Deep visual demo for HourFormat enum.
/// Shows 12-hour vs 24-hour time format options.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('HourFormat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FormatPreview('h (12-hour)', '3:45 PM'),
          const SizedBox(width: 24),
          _FormatPreview('H (24-hour)', '15:45'),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Text('Used by TimeOfDayFormat', style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _FormatPreview extends StatelessWidget {
  final String label;
  final String time;
  const _FormatPreview(this.label, this.time);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(time, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
