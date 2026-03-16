import 'package:flutter/material.dart';

/// Deep visual demo for text selection toolbar.
/// Context menu for text selection actions.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextSelectionToolbar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4), boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 8)]),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToolbarButton(Icons.cut, 'Cut'),
            _ToolbarDivider(),
            _ToolbarButton(Icons.copy, 'Copy'),
            _ToolbarDivider(),
            _ToolbarButton(Icons.paste, 'Paste'),
            _ToolbarDivider(),
            _ToolbarButton(Icons.select_all, 'All'),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Column(
          children: [
            Text('customizableToolbar', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            SizedBox(height: 4),
            Text('Use buttonItems for custom actions', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    ],
  );
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ToolbarButton(this.icon, this.label);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 9)),
        ],
      ),
    );
  }
}

class _ToolbarDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 30, color: Colors.grey.shade600);
  }
}
