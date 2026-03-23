// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for DateRangePickerDialog - dialog for selecting date ranges.
/// Shows start and end date selection with visual range.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DateRangePickerDialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 260,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SELECT RANGE', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Mar 10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(' - ', style: TextStyle(color: Colors.white)),
                      Text('Mar 17', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Range visualization
            Row(
              children: List.generate(7, (i) {
                final inRange = i >= 2 && i <= 5;
                final isStart = i == 2;
                final isEnd = i == 5;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: inRange ? Colors.indigo.shade100 : Colors.transparent,
                      borderRadius: BorderRadius.horizontal(
                        left: isStart ? const Radius.circular(12) : Radius.zero,
                        right: isEnd ? const Radius.circular(12) : Radius.zero,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: (isStart || isEnd) ? Colors.indigo : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Text('${i + 10}', style: TextStyle(fontSize: 9, color: (isStart || isEnd) ? Colors.white : Colors.black))),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Start + End dates with visual range', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
