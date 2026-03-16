import 'package:flutter/material.dart';

/// Deep visual demo for DialogTheme - inherited widget for dialog theming.
/// Shows how theme cascades to child dialogs.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DialogTheme Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // Theme inheritance
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('DialogTheme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ThemedDialog(Colors.purple.shade50),
                const SizedBox(width: 12),
                _ThemedDialog(Colors.purple.shade50),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Access via DialogTheme.of(context)', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThemedDialog extends StatelessWidget {
  final Color color;
  const _ThemedDialog(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: const Center(child: Icon(Icons.chat_bubble_outline, color: Colors.purple)),
    );
  }
}
