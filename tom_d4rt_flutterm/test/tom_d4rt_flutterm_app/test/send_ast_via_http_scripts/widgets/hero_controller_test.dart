// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== HeroController Deep Demo (Harness-Safe) ===');

  const tracks = <String>[
    'observer timeline',
    'tween comparison',
    'diversion scene',
    'controller switch',
    'practical workspace',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'HeroController',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...tracks.map((track) => ListTile(title: Text(track))),
          ],
        ),
      ),
    ),
  );
}
