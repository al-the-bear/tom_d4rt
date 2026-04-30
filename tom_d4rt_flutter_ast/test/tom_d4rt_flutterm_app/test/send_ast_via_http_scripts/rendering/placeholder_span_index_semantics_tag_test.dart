// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== PlaceholderSpanIndexSemanticsTag Deep Demo (Harness-Safe) ===');

  final tags = <String>['headline', 'caption', 'icon'];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'PlaceholderSpan Semantics Tags',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...tags.map((t) => ListTile(title: Text('tag: $t'))),
          ],
        ),
      ),
    ),
  );
}
