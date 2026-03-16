import 'package:flutter/material.dart';

/// Deep visual demo for SegmentedButton state management.
/// Stateful selection handling for segmented buttons.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SegmentedButton State', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SegmentDemo('Day', true),
                _SegmentDemo('Week', false),
                _SegmentDemo('Month', false),
              ],
            ),
            const SizedBox(height: 12),
            const Text("selected: {CalendarView.day}", style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            const SizedBox(height: 4),
            const Text('onSelectionChanged:', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            const Text('(Set<T> newSelection) { }', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Type-safe enum selection', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _SegmentDemo extends StatelessWidget {
  final String label;
  final bool selected;
  const _SegmentDemo(this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.white,
        border: Border.all(color: Colors.blue),
        borderRadius: label == 'Day' ? const BorderRadius.horizontal(left: Radius.circular(16)) : label == 'Month' ? const BorderRadius.horizontal(right: Radius.circular(16)) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected) const Icon(Icons.check, size: 12, color: Colors.white),
          if (selected) const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 10, color: selected ? Colors.white : Colors.blue)),
        ],
      ),
    );
  }
}
