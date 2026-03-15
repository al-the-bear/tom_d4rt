import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final color = ColorTween(begin: Colors.transparent, end: Colors.black54).animate(
    const AlwaysStoppedAnimation<double>(0.7),
  );

  return Stack(
    children: [
      Container(
        width: 300,
        height: 180,
        color: Colors.teal.shade100,
        alignment: Alignment.center,
        child: const Text('Underlying content'),
      ),
      SizedBox(
        width: 300,
        height: 180,
        child: AnimatedModalBarrier(color: color, dismissible: false),
      ),
      const SizedBox(
        width: 300,
        height: 180,
        child: Center(
          child: Text(
            'AnimatedModalBarrier overlay',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
