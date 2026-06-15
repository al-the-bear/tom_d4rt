// Copy-paste snippet for the "Paste & Run" tab.
//
// A paste snippet is a single Dart file with a top-level
// `Widget build(BuildContext context)` — exactly what
// SourceFlutterD4rt.build<Widget>(source, context) calls.
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Hello Card')),
    body: Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.flutter_dash, size: 48, color: Colors.indigo),
              SizedBox(height: 12),
              Text(
                'Hello from D4rt!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('Edit this code and press Execute.'),
            ],
          ),
        ),
      ),
    ),
  );
}
