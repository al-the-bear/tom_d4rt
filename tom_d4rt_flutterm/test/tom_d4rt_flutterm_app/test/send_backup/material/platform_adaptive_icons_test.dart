import 'package:flutter/material.dart';

/// Deep visual demo for platform adaptive icons.
/// Icons that adapt to iOS vs Android.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Platform Adaptive Icons', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PlatformIcon('Android', Icons.arrow_back, Icons.more_vert),
          const SizedBox(width: 32),
          _PlatformIcon('iOS', Icons.arrow_back_ios, Icons.more_horiz),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Icons.adaptive.arrow_back', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _PlatformIcon extends StatelessWidget {
  final String platform;
  final IconData back;
  final IconData more;
  const _PlatformIcon(this.platform, this.back, this.more);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Icon(back, size: 20),
              const SizedBox(width: 16),
              Icon(more, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(platform, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
