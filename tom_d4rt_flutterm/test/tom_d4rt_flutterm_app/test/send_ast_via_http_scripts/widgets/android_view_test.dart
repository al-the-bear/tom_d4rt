import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AndroidView embedding concept', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 140, height: 120, color: Colors.blueGrey.shade100, alignment: Alignment.center, child: const Text('Flutter UI')),
          const SizedBox(width: 8),
          Container(width: 140, height: 120, color: Colors.green.shade200, alignment: Alignment.center, child: const Text('AndroidView area')),
        ],
      ),
    ],
  );
}
