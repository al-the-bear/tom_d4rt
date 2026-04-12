// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DefaultSelectionStyle Deep Demo (Harness-Safe) ===');

  const zones = <String>['primary zone', 'secondary zone', 'merge preview'];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'DefaultSelectionStyle',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...zones.map(
              (zone) => DefaultSelectionStyle.merge(
                selectionColor: Colors.blue.withValues(alpha: 0.18),
                cursorColor: Colors.blue,
                child: Card(child: ListTile(title: Text(zone))),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
