import 'package:flutter/material.dart';

/// Deep visual demo for DatetimeUtils - utility methods for DateTime operations.
/// Shows common date manipulation helpers.
dynamic build(BuildContext context) {
  final now = DateTime.now();
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DateTime Utils Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _UtilRow('dateOnly()', 'Strips time component'),
            _UtilRow('isSameDay()', 'Compare dates only'),
            _UtilRow('monthDelta()', 'Months between dates'),
            _UtilRow('addMonths()', 'Add months to date'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Text('Today: ${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}', style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
            Text('Date only: ${DateUtils.dateOnly(now)}', style: const TextStyle(fontSize: 10, fontFamily: 'monospace')),
          ],
        ),
      ),
    ],
  );
}

class _UtilRow extends StatelessWidget {
  final String method;
  final String desc;
  const _UtilRow(this.method, this.desc);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(4)),
            child: Text(method, style: const TextStyle(fontSize: 9, color: Colors.white, fontFamily: 'monospace')),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(desc, style: const TextStyle(fontSize: 10))),
        ],
      ),
    );
  }
}
