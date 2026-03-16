import 'package:flutter/material.dart';

/// Deep visual demo for TabPageSelector widget.
/// Dot indicator showing position in a PageView.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TabPageSelector', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            const Center(child: Text('Page 2', style: TextStyle(fontSize: 14, color: Colors.grey))),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Dot(false),
                  const SizedBox(width: 8),
                  _Dot(true),
                  const SizedBox(width: 8),
                  _Dot(false),
                  const SizedBox(width: 8),
                  _Dot(false),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('controller, indicatorSize, color, selectedColor', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _Dot extends StatelessWidget {
  final bool selected;
  const _Dot(this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: selected ? 12 : 8,
      height: selected ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? Colors.blue : Colors.grey.shade400,
      ),
    );
  }
}
