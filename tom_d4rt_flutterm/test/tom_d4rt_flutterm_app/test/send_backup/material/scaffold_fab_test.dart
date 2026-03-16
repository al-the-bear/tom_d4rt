import 'package:flutter/material.dart';

/// Deep visual demo for Scaffold FAB locations.
/// Different floatingActionButtonLocation values.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('FAB Locations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FabLocationDemo('endFloat', Alignment.bottomRight),
          const SizedBox(width: 12),
          _FabLocationDemo('centerFloat', Alignment.bottomCenter),
          const SizedBox(width: 12),
          _FabLocationDemo('endDocked', Alignment.bottomRight, docked: true),
        ],
      ),
      const SizedBox(height: 12),
      const Text('floatingActionButtonLocation', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _FabLocationDemo extends StatelessWidget {
  final String label;
  final Alignment align;
  final bool docked;
  const _FabLocationDemo(this.label, this.align, {this.docked = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 80,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: Stack(
            children: [
              if (docked) Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 12, color: Colors.grey.shade200)),
              Positioned(
                right: align == Alignment.bottomCenter ? null : 4,
                left: align == Alignment.bottomCenter ? 20 : null,
                bottom: docked ? 6 : 4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: Colors.white, size: 10),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}
