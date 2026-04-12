// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderEditablePainter Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'RenderEditable Painter',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text('Bounded text preview (no editable layout path).'),
              SizedBox(height: 8),
              Card(child: Padding(padding: EdgeInsets.all(12), child: Text('Painter summary'))),
            ],
          ),
        ),
      ),
    ),
  );
}
