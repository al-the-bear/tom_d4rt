import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Animatedgrid demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SizedBox(
        width: 300,
        height: 170,
        child: GridView.count(
          crossAxisCount: 4,
          children: [
            for (var i = 0; i < 12; i++)
              Card(
                color: Colors.indigo[(i % 8 + 1) * 100],
                child: Center(child: Text('$i')),
              ),
          ],
        ),
      ),
    ],
  );
}
