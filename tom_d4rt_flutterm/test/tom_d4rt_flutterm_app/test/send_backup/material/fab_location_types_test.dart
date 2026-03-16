import 'package:flutter/material.dart';

/// Deep visual demo for FloatingActionButtonLocation types.
/// Shows all built-in FAB location options.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FAB Location Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _LocationBox('centerFloat', Alignment.bottomCenter, false),
          _LocationBox('centerDocked', Alignment.bottomCenter, true),
          _LocationBox('endFloat', Alignment.bottomRight, false),
          _LocationBox('endDocked', Alignment.bottomRight, true),
          _LocationBox('startFloat', Alignment.bottomLeft, false),
          _LocationBox('startTop', Alignment.topRight, false),
        ],
      ),
      const SizedBox(height: 12),
      const Text('FloatingActionButtonLocation variants', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _LocationBox extends StatelessWidget {
  final String name;
  final Alignment align;
  final bool docked;
  const _LocationBox(this.name, this.align, this.docked);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 48,
          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
          child: Stack(
            children: [
              if (docked) Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 12, color: Colors.blue.shade300)),
              Align(
                alignment: docked ? Alignment(align.x, 0.5) : align,
                child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}
