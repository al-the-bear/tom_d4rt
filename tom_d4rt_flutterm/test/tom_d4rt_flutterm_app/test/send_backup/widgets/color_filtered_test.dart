import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ColorFiltered demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SizedBox(
        width: 300,
        height: 170,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.purple.shade200, Colors.blue.shade200]),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 180,
                height: 90,
                color: Colors.white70,
                alignment: Alignment.center,
                child: const Text('Filter region'),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
