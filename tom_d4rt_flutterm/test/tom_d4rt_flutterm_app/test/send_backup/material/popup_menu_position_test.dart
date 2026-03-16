import 'package:flutter/material.dart';

/// Deep visual demo for popup menu positioning.
/// Shows different position values.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Popup Menu Position', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PositionDemo('over', const Offset(0, 0)),
          const SizedBox(width: 16),
          _PositionDemo('under', const Offset(0, 40)),
        ],
      ),
      const SizedBox(height: 12),
      const Text('position: PopupMenuPosition', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _PositionDemo extends StatelessWidget {
  final String label;
  final Offset offset;
  const _PositionDemo(this.label, this.offset);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.more_vert, size: 20),
              ),
              Positioned(
                top: offset.dy,
                child: Container(
                  width: 60,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('A', style: TextStyle(fontSize: 9)),
                      Text('B', style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
