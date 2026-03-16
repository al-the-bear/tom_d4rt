import 'package:flutter/material.dart';

/// Deep visual demo for Gregorian calendar delegate.
/// Shows date picker with Gregorian calendar system.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Gregorian Calendar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          children: [
            // Month header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.chevron_left, size: 20),
                Text('March 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.chevron_right, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            // Day headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((d) => SizedBox(width: 24, child: Center(child: Text(d, style: const TextStyle(fontSize: 10, color: Colors.grey))))).toList(),
            ),
            const SizedBox(height: 8),
            // Days grid (simplified)
            ...List.generate(3, (week) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (day) {
                  final dayNum = week * 7 + day + 1;
                  final selected = dayNum == 15;
                  return Container(
                    width: 24, height: 24,
                    decoration: selected ? const BoxDecoration(color: Colors.blue, shape: BoxShape.circle) : null,
                    child: Center(child: Text('$dayNum', style: TextStyle(fontSize: 10, color: selected ? Colors.white : Colors.black))),
                  );
                }),
              ),
            )),
          ],
        ),
      ),
    ],
  );
}
