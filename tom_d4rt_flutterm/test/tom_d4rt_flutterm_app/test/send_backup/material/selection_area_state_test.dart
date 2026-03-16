import 'package:flutter/material.dart';

/// Deep visual demo for SelectionAreaState.
/// State class managing text selection across widgets.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SelectionAreaState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('SelectionArea.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MethodBox('.selectAll()', Icons.select_all),
                const SizedBox(width: 8),
                _MethodBox('.clear()', Icons.clear),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Text('selectableRegion: SelectionRegistrar', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Manages SelectionContainer state', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MethodBox extends StatelessWidget {
  final String method;
  final IconData icon;
  const _MethodBox(this.method, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Icon(icon, color: Colors.teal, size: 18),
          const SizedBox(height: 4),
          Text(method, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
        ],
      ),
    );
  }
}
