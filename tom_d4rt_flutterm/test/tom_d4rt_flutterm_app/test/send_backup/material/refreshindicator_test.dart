import 'package:flutter/material.dart';

/// Deep visual demo for RefreshIndicator widget.
/// Pull-to-refresh functionality.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RefreshIndicator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 160,
        height: 140,
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Positioned(
              top: 40,
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            Positioned(
              top: 80,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: const Text('Content pulled down', style: TextStyle(fontSize: 10)),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('onRefresh: Future callback', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
