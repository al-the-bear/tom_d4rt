import 'package:flutter/material.dart';

/// Deep visual demo for showDatePicker function.
/// Shows a Material date picker dialog.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showDatePicker()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
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
                  Text('Select date', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  SizedBox(height: 4),
                  Text('Tue, Jan 28', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.chevron_left, size: 16),
                      const Text('January 2025', style: TextStyle(fontSize: 10)),
                      const Icon(Icons.chevron_right, size: 16),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _CalendarGrid(),
                ],
              ),
            ),
            const Divider(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('CANCEL', style: TextStyle(fontSize: 10))),
                TextButton(onPressed: () {}, child: const Text('OK', style: TextStyle(fontSize: 10))),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class _CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GridView.count(
        crossAxisCount: 7,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(14, (i) {
          final day = i + 20;
          final selected = day == 28;
          return Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(shape: BoxShape.circle, color: selected ? Colors.blue : null),
            alignment: Alignment.center,
            child: Text('\$day', style: TextStyle(fontSize: 8, color: selected ? Colors.white : null)),
          );
        }),
      ),
    );
  }
}
