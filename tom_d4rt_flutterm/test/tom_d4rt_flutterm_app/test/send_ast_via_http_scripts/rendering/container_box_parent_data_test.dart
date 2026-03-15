import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _DemoParentData extends ContainerBoxParentData<RenderBox> {}

dynamic build(BuildContext context) {
  final dataA = _DemoParentData()..offset = const Offset(20, 20);
  final dataB = _DemoParentData()..offset = const Offset(120, 50);
  final dataC = _DemoParentData()..offset = const Offset(70, 120);

  Widget marker(String label, Offset offset, Color color) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(
        width: 70,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ContainerBoxParentData Visual Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 240,
          height: 180,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
            ),
            child: Stack(
              children: [
                marker('A', dataA.offset, Colors.blue),
                marker('B', dataB.offset, Colors.green),
                marker('C', dataC.offset, Colors.deepOrange),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('A=${dataA.offset}, B=${dataB.offset}, C=${dataC.offset}'),
      ],
    ),
  );
}
