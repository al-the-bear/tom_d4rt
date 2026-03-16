import 'package:flutter/material.dart';

/// Deep visual demo for IconAlignment enum.
/// Shows icon position options in buttons.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('IconAlignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _AlignmentPreview('start', Icons.arrow_back, true),
      const SizedBox(height: 8),
      _AlignmentPreview('end', Icons.arrow_forward, false),
      const SizedBox(height: 12),
      const Text('Used in ButtonStyleButton.iconAlignment', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _AlignmentPreview extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isStart;
  const _AlignmentPreview(this.label, this.icon, this.isStart);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isStart) Icon(icon, color: Colors.white, size: 18),
          if (isStart) const SizedBox(width: 8),
          Text('Click Me', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          if (!isStart) const SizedBox(width: 8),
          if (!isStart) Icon(icon, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}
