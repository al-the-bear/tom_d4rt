import 'package:flutter/material.dart';

/// Deep visual demo for DateUtils - Material date utility methods.
/// Shows common date operations like firstDayOfMonth, addDaysToDate.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DateUtils Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _MethodCard('dateOnly', 'Remove time from DateTime'),
            _MethodCard('isSameDay', 'Compare two dates'),
            _MethodCard('isSameMonth', 'Compare month/year'),
            _MethodCard('getDaysInMonth', 'Days in given month'),
            _MethodCard('addMonthsToMonthDate', 'Add months'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Static helper methods for dates', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MethodCard extends StatelessWidget {
  final String method;
  final String desc;
  const _MethodCard(this.method, this.desc);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          Text('$method()', style: const TextStyle(fontSize: 10, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(desc, style: const TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}
