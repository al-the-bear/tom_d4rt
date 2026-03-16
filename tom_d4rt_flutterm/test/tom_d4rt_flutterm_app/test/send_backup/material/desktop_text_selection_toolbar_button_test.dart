import 'package:flutter/material.dart';

/// Deep visual demo for DesktopTextSelectionToolbarButton - individual toolbar button.
/// Shows button styling and interaction states.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Toolbar Button', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ButtonState('Normal', Colors.grey.shade100, Colors.black),
          const SizedBox(width: 8),
          _ButtonState('Hovered', Colors.blue.shade50, Colors.blue),
          const SizedBox(width: 8),
          _ButtonState('Disabled', Colors.grey.shade50, Colors.grey),
        ],
      ),
      const SizedBox(height: 16),
      // In context
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToolbarBtn(Icons.content_cut, 'Cut'),
            _ToolbarBtn(Icons.content_copy, 'Copy'),
            _ToolbarBtn(Icons.content_paste, 'Paste'),
          ],
        ),
      ),
    ],
  );
}

class _ButtonState extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  const _ButtonState(this.label, this.bg, this.fg);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
          child: Text('Copy', style: TextStyle(color: fg, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class _ToolbarBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ToolbarBtn(this.icon, this.label);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          Text(label, style: const TextStyle(fontSize: 8)),
        ],
      ),
    );
  }
}
