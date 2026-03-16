import 'package:flutter/material.dart';

/// Deep visual demo for ToggleButtons widget.
/// Row of toggle buttons for selection.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ToggleButtons', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToggleItem(Icons.format_bold, true),
            _Separator(),
            _ToggleItem(Icons.format_italic, false),
            _Separator(),
            _ToggleItem(Icons.format_underline, true),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const Text('Single select:', style: TextStyle(fontSize: 10)),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.purple), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AlignItem(Icons.format_align_left, false),
            _Separator(color: Colors.purple),
            _AlignItem(Icons.format_align_center, true),
            _Separator(color: Colors.purple),
            _AlignItem(Icons.format_align_right, false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('isSelected, onPressed, renderBorder', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _ToggleItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  const _ToggleItem(this.icon, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: selected ? Colors.blue.shade100 : null,
      child: Icon(icon, color: Colors.blue, size: 18),
    );
  }
}

class _AlignItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  const _AlignItem(this.icon, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: selected ? Colors.purple.shade100 : null,
      child: Icon(icon, color: Colors.purple, size: 18),
    );
  }
}

class _Separator extends StatelessWidget {
  final Color color;
  const _Separator({this.color = Colors.blue});
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 34, color: color);
  }
}
