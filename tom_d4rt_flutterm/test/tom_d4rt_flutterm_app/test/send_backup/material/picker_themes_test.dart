import 'package:flutter/material.dart';

/// Deep visual demo for picker theming.
/// DatePickerTheme, TimePickerTheme.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Picker Themes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PickerPreview('Date', Icons.calendar_today, Colors.blue),
          const SizedBox(width: 24),
          _PickerPreview('Time', Icons.access_time, Colors.orange),
        ],
      ),
      const SizedBox(height: 12),
      const Text('DatePickerThemeData, TimePickerThemeData', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _PickerPreview extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _PickerPreview(this.label, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(color: color.withAlpha(30), borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
                child: Text(label == 'Date' ? 'Jan 15' : '10:30', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text('$label Picker', style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
