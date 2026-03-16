import 'package:flutter/material.dart';

/// Deep visual demo for TimeOfDay class.
/// Time representation without timezone.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TimeOfDay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TimeBox('hour', '10'),
                const Text(' : ', style: TextStyle(fontSize: 24)),
                _TimeBox('minute', '30'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PeriodChip('AM', true),
                const SizedBox(width: 8),
                _PeriodChip('PM', false),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('hour, minute, period, format()', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _TimeBox extends StatelessWidget {
  final String label;
  final String value;
  const _TimeBox(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _PeriodChip(this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? Colors.purple : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.purple),
      ),
      child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.purple, fontSize: 10)),
    );
  }
}
