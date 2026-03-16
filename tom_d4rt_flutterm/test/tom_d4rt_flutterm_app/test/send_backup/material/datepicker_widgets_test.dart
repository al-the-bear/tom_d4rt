import 'package:flutter/material.dart';

/// Deep visual demo for DatePickerDialog - Material date picker dialog.
/// Shows the dialog structure with calendar and input modes.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DatePickerDialog Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // Dialog mockup
      Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: const Row(
                children: [
                  Text('SELECT DATE', style: TextStyle(color: Colors.white70, fontSize: 10)),
                ],
              ),
            ),
            // Date display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.blue,
              child: const Text('Thu, Mar 15', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            // Calendar grid
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Icon(Icons.chevron_left, size: 18), Text('March 2024', style: TextStyle(fontWeight: FontWeight.bold)), Icon(Icons.chevron_right, size: 18)],
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.5,
                    children: List.generate(14, (i) {
                      final day = i + 1;
                      final selected = day == 15;
                      return Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(color: selected ? Colors.blue : null, shape: BoxShape.circle),
                        child: Center(child: Text('$day', style: TextStyle(fontSize: 9, color: selected ? Colors.white : Colors.black))),
                      );
                    }),
                  ),
                ],
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: const Text('CANCEL')),
                  TextButton(onPressed: () {}, child: const Text('OK')),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
