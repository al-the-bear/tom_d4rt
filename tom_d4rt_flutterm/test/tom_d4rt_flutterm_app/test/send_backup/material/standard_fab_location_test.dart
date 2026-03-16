import 'package:flutter/material.dart';

/// Deep visual demo for StandardFabLocation.
/// Standard FAB positioning implementations.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('StandardFabLocation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FabPositionDemo('endTop', Alignment.topRight, false),
          const SizedBox(width: 8),
          _FabPositionDemo('endFloat', Alignment.bottomRight, false),
          const SizedBox(width: 8),
          _FabPositionDemo('endDocked', Alignment.bottomRight, true),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FabPositionDemo('centerFloat', Alignment.bottomCenter, false),
          const SizedBox(width: 8),
          _FabPositionDemo('centerDocked', Alignment.bottomCenter, true),
          const SizedBox(width: 8),
          _FabPositionDemo('startFloat', Alignment.bottomLeft, false),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Composable location classes', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _FabPositionDemo extends StatelessWidget {
  final String name;
  final Alignment align;
  final bool docked;
  const _FabPositionDemo(this.name, this.align, this.docked);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 60,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: Stack(
            children: [
              if (docked) Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 10, color: Colors.grey.shade200)),
              Align(
                alignment: align,
                child: Transform.translate(
                  offset: Offset(
                    align.x > 0 ? -4 : align.x < 0 ? 4 : 0,
                    align.y > 0 ? (docked ? -5 : -4) : 4,
                  ),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Text(name, style: const TextStyle(fontSize: 7)),
      ],
    );
  }
}
