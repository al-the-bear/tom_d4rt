import 'package:flutter/material.dart';

/// Deep visual demo for DropdownButton - classic Material dropdown.
/// Shows dropdown button with value and items.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DropdownButton Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Dropdown button mockup
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Medium', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 24),
                  Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // States
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DropdownState('Enabled', Colors.blue),
                const SizedBox(width: 12),
                _DropdownState('Disabled', Colors.grey),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Classic dropdown for simple selection', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DropdownState extends StatelessWidget {
  final String label;
  final Color color;
  const _DropdownState(this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, color: color)),
    );
  }
}
