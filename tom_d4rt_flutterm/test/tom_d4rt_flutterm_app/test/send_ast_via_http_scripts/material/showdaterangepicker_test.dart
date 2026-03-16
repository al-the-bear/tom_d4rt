import 'package:flutter/material.dart';

/// Deep visual demo for showDateRangePicker function.
/// Shows a Material date range picker dialog.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showDateRangePicker()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8)]),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select range', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  SizedBox(height: 4),
                  Text('Jan 15 - Jan 22', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _RangeCalendarDemo(),
            ),
          ],
        ),
      ),
    ],
  );
}

class _RangeCalendarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (i) {
        final day = 15 + i;
        final isStart = day == 15;
        final isEnd = day == 21;
        final inRange = day >= 15 && day <= 21;
        return Container(
          width: 22,
          height: 22,
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: inRange ? (isStart || isEnd ? Colors.blue : Colors.blue.shade100) : null,
            borderRadius: isStart ? const BorderRadius.horizontal(left: Radius.circular(11)) : isEnd ? const BorderRadius.horizontal(right: Radius.circular(11)) : null,
          ),
          alignment: Alignment.center,
          child: Text('\$day', style: TextStyle(fontSize: 9, color: isStart || isEnd ? Colors.white : null)),
        );
      }),
    );
  }
}
