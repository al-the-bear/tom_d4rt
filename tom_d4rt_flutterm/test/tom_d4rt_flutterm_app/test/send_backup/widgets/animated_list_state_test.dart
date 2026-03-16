import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text(
        'AnimatedListState concept demo',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      SizedBox(
        width: 300,
        height: 180,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            color: Colors.blue[(index + 2) * 100],
            child: Text('Animated row ${index + 1}'),
          ),
        ),
      ),
    ],
  );
}
