import 'package:flutter/material.dart';

/// Deep visual demo for PopupMenuItemState.
/// State class for PopupMenuItem widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PopupMenuItemState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('State Lifecycle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StatePhase('init', Icons.play_arrow),
                const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                _StatePhase('build', Icons.construction),
                const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                _StatePhase('tap', Icons.touch_app),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('buildChild, handleTap override', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _StatePhase extends StatelessWidget {
  final String label;
  final IconData icon;
  const _StatePhase(this.label, this.icon);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 20, color: Colors.purple),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}
