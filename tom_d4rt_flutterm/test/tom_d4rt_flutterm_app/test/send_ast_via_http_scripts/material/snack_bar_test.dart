import 'package:flutter/material.dart';

/// Deep visual demo for SnackBar widget.
/// Brief message displayed at screen bottom.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SnackBar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _SnackBarDemo('Simple', 'Message sent', null),
      const SizedBox(height: 8),
      _SnackBarDemo('With Action', 'Item deleted', 'UNDO'),
      const SizedBox(height: 8),
      _SnackBarDemo('With Icon', 'Download complete', null, icon: Icons.check_circle),
      const SizedBox(height: 12),
      const Text('behavior: fixed | floating', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _SnackBarDemo extends StatelessWidget {
  final String label;
  final String message;
  final String? action;
  final IconData? icon;
  const _SnackBarDemo(this.label, this.message, this.action, {this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        const SizedBox(height: 2),
        Container(
          width: 220,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              if (icon != null) ...[Icon(icon, color: Colors.green, size: 16), const SizedBox(width: 8)],
              Expanded(child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 11))),
              if (action != null) Text(action!, style: const TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
