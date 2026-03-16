import 'package:flutter/material.dart';

/// Deep visual demo for RefreshProgressIndicator widget.
/// Adaptive progress indicator for refresh.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RefreshProgressIndicator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: const Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      ),
      const SizedBox(height: 12),
      const Text('Shows during pull-to-refresh', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
