import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text(
        'AndroidViewSurface integration concept',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Container(
        width: 300,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Native Android surface region',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}
