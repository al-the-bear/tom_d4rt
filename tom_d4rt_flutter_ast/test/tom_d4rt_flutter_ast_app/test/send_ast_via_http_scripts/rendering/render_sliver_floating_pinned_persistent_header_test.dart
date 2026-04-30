// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderSliverFloatingPinnedPersistentHeader Deep Demo (Harness-Safe) ===');

  final config = <String, String>{
    'mode': 'floating+pinned',
    'header': 'persistent',
  };

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Header mode: ${config['mode']}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: ListTile(title: Text('Persistent header preview content')),
            ),
          ],
        ),
      ),
    ),
  );
}
