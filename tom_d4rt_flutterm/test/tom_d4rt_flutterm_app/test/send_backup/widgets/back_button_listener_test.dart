import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('BackButtonListener demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SizedBox(
        width: 300,
        height: 170,
        child: ListView(
          children: [
            for (var i = 0; i < 8; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(10),
                color: Colors.blue[(i + 2) * 100],
                child: Text('List row ${i + 1}'),
              ),
          ],
        ),
      ),
    ],
  );
}
