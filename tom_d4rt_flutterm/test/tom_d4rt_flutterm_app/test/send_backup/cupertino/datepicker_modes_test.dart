import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoDatePicker modes.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DatePicker Modes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8, runSpacing: 8,
        children: const [
          _ModeCard('date', 'Jan 15, 2025'),
          _ModeCard('time', '10:30 AM'),
          _ModeCard('dateAndTime', 'Jan 15, 10:30'),
          _ModeCard('monthYear', 'January 2025'),
        ],
      ),
      const SizedBox(height: 12),
      const Text('CupertinoDatePickerMode enum', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _ModeCard extends StatelessWidget {
  final String mode, example;
  const _ModeCard(this.mode, this.example);
  @override
  Widget build(BuildContext context) => Container(
    width: 100, padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(8)),
    child: Column(
      children: [Text(mode, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(example, style: const TextStyle(fontSize: 11))],
    ),
  );
}
