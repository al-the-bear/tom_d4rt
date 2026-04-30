// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== PlatformViewRenderBox Deep Demo (Harness-Safe) ===');

  final controllerState = <String>['created', 'attached', 'ready'];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Platform View Render Box',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...controllerState.map((s) => ListTile(title: Text('controller: $s'))),
          ],
        ),
      ),
    ),
  );
}
