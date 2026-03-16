import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Align demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Container(
        width: 260,
        height: 120,
        color: Colors.grey.shade300,
        child: Align(
          alignment: const Alignment(0.7, -0.6),
          child: Container(width: 64, height: 36, color: Colors.blue),
        ),
      ),
    ],
  );
}
