import 'package:flutter/material.dart';

/// Deep visual demo for DatePickerEntryMode - enum for date picker input modes.
/// Shows calendar, input, and combined modes.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DatePickerEntryMode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          _ModeCard('calendar', Icons.calendar_today, 'Pick from calendar'),
          _ModeCard('input', Icons.keyboard, 'Type date manually'),
          _ModeCard('calendarOnly', Icons.calendar_month, 'Calendar only'),
          _ModeCard('inputOnly', Icons.edit, 'Input only'),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Control date picker interaction style', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ModeCard extends StatelessWidget {
  final String mode;
  final IconData icon;
  final String desc;
  const _ModeCard(this.mode, this.icon, this.desc);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(height: 4),
          Text(mode, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          Text(desc, style: const TextStyle(fontSize: 8), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
