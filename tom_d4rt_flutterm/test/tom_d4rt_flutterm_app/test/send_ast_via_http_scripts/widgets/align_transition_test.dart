import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final animation = AlwaysStoppedAnimation<AlignmentGeometry>(
    const Alignment(0.6, -0.6),
  );

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AlignTransition demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Container(
        width: 260,
        height: 120,
        color: Colors.amber.shade50,
        child: AlignTransition(
          alignment: animation,
          child: Container(width: 56, height: 56, color: Colors.deepOrange),
        ),
      ),
    ],
  );
}
