import 'package:flutter/material.dart';

/// Deep visual demo for showModalBottomSheet function.
/// Shows a modal Material Design bottom sheet.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showModalBottomSheet()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 130,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Container(color: Colors.black26),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(width: 32, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ActionItem(Icons.share, 'Share'),
                        _ActionItem(Icons.link, 'Link'),
                        _ActionItem(Icons.edit, 'Edit'),
                        _ActionItem(Icons.delete, 'Delete'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('isDismissible, enableDrag', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionItem(this.icon, this.label);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade700),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}
