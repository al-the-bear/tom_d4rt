import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  final start = RawFloatingCursorPoint(state: FloatingCursorDragState.Start, offset: const Offset(30, 20));
  final update = RawFloatingCursorPoint(state: FloatingCursorDragState.Update, offset: const Offset(120, 45));
  final end = RawFloatingCursorPoint(state: FloatingCursorDragState.End, offset: const Offset(180, 28));

  Widget dot(Offset? o, Color color) {
    final offset = o ?? Offset.zero;
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('RawFloatingCursorPoint Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          width: 220,
          height: 80,
          child: DecoratedBox(
            decoration: BoxDecoration(border: Border.all(color: Colors.black26), borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                dot(start.offset, Colors.green),
                dot(update.offset, Colors.blue),
                dot(end.offset, Colors.red),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('start=${start.offset} update=${update.offset} end=${end.offset}'),
      ],
    ),
  );
}