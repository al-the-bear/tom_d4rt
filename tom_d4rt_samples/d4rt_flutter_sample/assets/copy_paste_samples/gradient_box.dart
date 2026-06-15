// Copy-paste snippet: a full-screen gradient with centered text.
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.indigo, Colors.purple, Colors.pink],
        ),
      ),
      child: const Center(
        child: Text(
          'Gradient',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
