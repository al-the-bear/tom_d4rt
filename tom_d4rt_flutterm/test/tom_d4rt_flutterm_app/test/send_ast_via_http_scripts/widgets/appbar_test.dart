import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Appbar demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SizedBox(
        width: 320,
        height: 140,
        child: Material(
          color: Colors.white,
          child: Column(
            children: [
              AppBar(title: const Text('Demo AppBar')),
            ],
          ),
        ),
      ),
    ],
  );
}
