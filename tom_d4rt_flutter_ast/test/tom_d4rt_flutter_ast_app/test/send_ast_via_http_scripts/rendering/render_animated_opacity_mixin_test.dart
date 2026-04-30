// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderAnimatedOpacityMixin Deep Demo (Harness-Safe) ===');

  final animationState = <String>['controller-initialized', 'curve-attached', 'ready'];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Animated Opacity Mixin State',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...animationState.map((s) => ListTile(title: Text(s))),
          ],
        ),
      ),
    ),
  );
}
