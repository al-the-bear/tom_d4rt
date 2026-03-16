import 'package:flutter/material.dart';

/// Deep visual demo for Card ink splash.
/// Shows card with ink well effects.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Card Ink Splash')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Card with InkWell', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Card(
          child: InkWell(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Card tapped!'))),
            borderRadius: BorderRadius.circular(12),
            child: const Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(Icons.touch_app, size: 48, color: Colors.blue),
                  SizedBox(height: 16),
                  Text('Tap me', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('See the ink splash effect'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: InkWell(
            onTap: () {},
            splashColor: Colors.purple.withAlpha(100),
            highlightColor: Colors.purple.withAlpha(50),
            child: const Padding(
              padding: EdgeInsets.all(24),
              child: Text('Custom splash color'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              splashFactory: InkRipple.splashFactory,
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Text('InkRipple factory'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
