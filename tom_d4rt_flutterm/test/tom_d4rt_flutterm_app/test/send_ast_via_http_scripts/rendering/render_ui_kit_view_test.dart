// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderUiKitView Deep Demo (Harness-Safe) ===');

  final facts = <String, String>{
    'viewType': 'demo/ui-kit-view',
    'mode': 'summary-only',
    'platformGuard': 'no implicit widget-state lookup',
  };

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'RenderUiKitView',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: const Text('Configured view type'),
                subtitle: Text(facts['viewType'] ?? 'unknown'),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Execution mode'),
                subtitle: Text(facts['mode'] ?? 'unknown'),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('State-context rule'),
                subtitle: Text(facts['platformGuard'] ?? 'unknown'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
