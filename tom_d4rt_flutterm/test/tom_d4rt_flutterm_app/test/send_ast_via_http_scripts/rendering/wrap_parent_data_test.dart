import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  final dataA = WrapParentData()..offset = const Offset(0, 0);
  final dataB = WrapParentData()..offset = const Offset(24, 0);
  final dataC = WrapParentData()..offset = const Offset(0, 30);

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('WrapParentData Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          width: 220,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              6,
              (index) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[(index + 1) * 100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Item ${index + 1}'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('A=${dataA.offset}, B=${dataB.offset}, C=${dataC.offset}'),
      ],
    ),
  );
}