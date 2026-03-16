import 'package:flutter/material.dart';

/// Deep visual demo for SearchController.
/// Controller for search view state and text.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SearchController', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('extends TextEditingController', style: TextStyle(fontFamily: 'monospace', fontSize: 9, fontStyle: FontStyle.italic)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _MethodBadge('.openView()', Icons.open_in_full),
                _MethodBadge('.closeView()', Icons.close_fullscreen),
                _MethodBadge('.text', Icons.text_fields),
                _MethodBadge('.isOpen', Icons.visibility),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Controls SearchAnchor state', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MethodBadge extends StatelessWidget {
  final String text;
  final IconData icon;
  const _MethodBadge(this.text, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.indigo),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
        ],
      ),
    );
  }
}
