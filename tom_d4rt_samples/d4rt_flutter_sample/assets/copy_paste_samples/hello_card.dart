// Copy-paste snippet for the "Paste & Run" tab.
//
// A paste snippet is a single Dart file with a top-level
// `Widget build(BuildContext context)` — exactly what
// SourceFlutterD4rt.build<Widget>(source, context) calls.
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Hello Card')),
    // Center when there is room; scroll instead of overflowing when the
    // available area is small. The vertical scroll view constrains the card
    // width to the viewport, so text wraps rather than overflowing sideways.
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.flutter_dash, size: 48, color: Colors.indigo),
                  SizedBox(height: 12),
                  Text(
                    'Hello from D4rt!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Edit this code and press Execute.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
