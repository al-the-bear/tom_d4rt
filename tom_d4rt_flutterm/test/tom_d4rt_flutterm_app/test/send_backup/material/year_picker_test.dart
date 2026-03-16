import 'package:flutter/material.dart';

/// Deep visual demo for YearPicker widget.
/// Grid of years for date picker.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('YearPicker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 160,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
              child: const Row(
                children: [
                  Icon(Icons.chevron_left, color: Colors.white, size: 18),
                  Spacer(),
                  Text('Select Year', style: TextStyle(color: Colors.white, fontSize: 12)),
                  Spacer(),
                  Icon(Icons.chevron_right, color: Colors.white, size: 18),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(8),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1.8,
                children: [
                  for (var y = 2020; y <= 2028; y++)
                    _YearCell(y, y == 2025),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('firstDate, lastDate, selectedDate, onChanged', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _YearCell extends StatelessWidget {
  final int year;
  final bool selected;
  const _YearCell(this.year, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.blue : null,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text('\$year', style: TextStyle(fontSize: 11, color: selected ? Colors.white : null, fontWeight: selected ? FontWeight.bold : null)),
    );
  }
}
