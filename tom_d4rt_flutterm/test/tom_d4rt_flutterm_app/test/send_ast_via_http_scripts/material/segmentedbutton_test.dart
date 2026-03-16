import 'package:flutter/material.dart';

/// Deep visual demo for SegmentedButton widget.
/// Material 3 segmented button for single or multi-selection.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SegmentedButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Segment(Icons.format_align_left, true),
            _Divider(),
            _Segment(Icons.format_align_center, false),
            _Divider(),
            _Segment(Icons.format_align_right, false),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const Text('Multi-select:', style: TextStyle(fontSize: 10)),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.purple), borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MultiSegment('S', true),
            _Divider(color: Colors.purple),
            _MultiSegment('M', true),
            _Divider(color: Colors.purple),
            _MultiSegment('L', false),
            _Divider(color: Colors.purple),
            _MultiSegment('XL', false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('multiSelectionEnabled property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _Segment extends StatelessWidget {
  final IconData icon;
  final bool selected;
  const _Segment(this.icon, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.blue.shade100 : null,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          if (selected) const Icon(Icons.check, size: 14, color: Colors.blue),
          if (selected) const SizedBox(width: 4),
          Icon(icon, size: 16, color: Colors.blue),
        ],
      ),
    );
  }
}

class _MultiSegment extends StatelessWidget {
  final String label;
  final bool selected;
  const _MultiSegment(this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: selected ? Colors.purple.shade100 : null, borderRadius: BorderRadius.circular(19)),
      child: Row(
        children: [
          if (selected) const Icon(Icons.check, size: 12, color: Colors.purple),
          if (selected) const SizedBox(width: 2),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.purple)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final Color color;
  const _Divider({this.color = Colors.blue});
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 24, color: color.withAlpha(100));
}
